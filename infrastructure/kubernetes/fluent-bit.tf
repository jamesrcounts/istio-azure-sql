locals {
  evh_configuration = jsondecode(module.configuration.imports["evh-configuration"])

  evh_broker            = "${nonsensitive(local.evh_configuration["name"])}.servicebus.windows.net:9093"
  evh_connection_string = local.evh_configuration["primary_connection_string"]
  evh_name              = nonsensitive(local.evh_configuration["topic"])
}

resource "helm_release" "fluent_bit" {
  atomic    = true
  chart     = "${path.module}/charts/fluent-bit-0.18.0"
  lint      = true
  name      = "fluent-bit"
  namespace = kubernetes_namespace.logging.metadata.0.name

  set {
    name  = "config.inputs"
    value = <<EOF
[INPUT]
    Name tail
    Path /var/log/containers/*.log
    multiline.parser docker\, cri
    Tag kube.*
    Mem_Buf_Limit 5MB
    Skip_Long_Lines On

[INPUT]
    Name systemd
    Tag host.*
    Systemd_Filter _SYSTEMD_UNIT=kubelet.service
    Read_From_Tail On
EOF
  }

  set_sensitive {
    name  = "config.outputs"
    value = <<EOF
[OUTPUT]
    Name        kafka
    Match       *
    Brokers     ${local.evh_broker}
    Topics      ${local.evh_name}
    Retry_Limit    2
    rdkafka.security.protocol SASL_SSL
    rdkafka.sasl.mechanism PLAIN
    rdkafka.sasl.username $ConnectionString
    rdkafka.sasl.password ${local.evh_connection_string}
    rdkafka.ssl.sa.location /usr/lib/ssl/certs/
    rdkafka.auto.offset.reset end
    rdkafka.request.timeout.ms 60000
    rdkafka.log.connection.close false
    rdkafka.queue.buffering.max.ms 1000
    rdkafka.queue.buffering.max.messages 300
    rdkafka.batch.num.messages 200
    rdkafka.compression.codec none
    rdkafka.request.required.acks 1
    rdkafka.queue.buffering.max.kbytes 10240
EOF
  }
}

resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}
