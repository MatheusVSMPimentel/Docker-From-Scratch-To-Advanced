FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["app-dotnet.csproj", "."]
RUN dotnet restore "app-dotnet.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "app-dotnet.csproj" -c $BUILD_CONFIGURATION -o /app/build
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "app-dotnet.csproj" -c $BUILD_CONFIGURATION -o /app/publish
FROM base AS final
ENV ASPNETCORE_URLS="http://+:8080"
ENV ASPNETCORE_ENVIRONMENT="Development"
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "app-dotnet.dll"]
