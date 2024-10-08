# Stage 1: Build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the csproj and restore dependencies
COPY BlazorApp.csproj .
RUN dotnet restore

# Copy the entire project and build it
COPY . .
RUN dotnet publish -c Release -o out

# Stage 2: Serve the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Expose the port the app runs on
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "BlazorApp.dll"]
