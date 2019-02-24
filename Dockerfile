#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

#FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-sac2016 AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#
#FROM microsoft/dotnet:2.1-sdk-nanoserver-sac2016 AS build
#WORKDIR /src
#COPY ["doc1/doc1.csproj", "doc1/"]
#RUN dotnet restore "doc1/doc1.csproj"
#COPY . .
#WORKDIR "/src/doc1"
#RUN dotnet build "doc1.csproj" -c Release -o /app
#
#FROM build AS publish
#RUN dotnet publish "doc1.csproj" -c Release -o /app
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app .
#ENTRYPOINT ["dotnet", "doc1.dll"]

FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /doc1
RUN dotnet new razor
RUN dotnet publish -c Release -o out
FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine
WORKDIR /doc1
COPY --from=build-env /doc1/out ./
ENTRYPOINT ["dotnet", "doc1.dll"]