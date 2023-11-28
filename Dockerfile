# 빌드 스테이지
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /src

# 프로젝트 파일 복사
COPY . .

# 패키지 복원
RUN dotnet restore "testapi.csproj"

# 소스 코드 복사
COPY . .

# 빌드
RUN dotnet build "testapi.csproj" -c Release -o /app/build

# 실행 파일 생성
RUN dotnet publish "testapi.csproj" -c Release -o /app/publish

# 런타임 스테이지
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# 실행
CMD ["dotnet", "testapi.dll"]
