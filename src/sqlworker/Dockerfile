FROM mcr.microsoft.com/dotnet/runtime:5.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["sqlworker.csproj", "app/sqlworker/"]
RUN dotnet restore "app/sqlworker/sqlworker.csproj"
COPY . app/sqlworker/
WORKDIR "/src/app/sqlworker"
RUN dotnet build "sqlworker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "sqlworker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "sqlworker.dll"]
