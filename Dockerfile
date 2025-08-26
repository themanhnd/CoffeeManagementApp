# Sử dụng multi-stage build để tối ưu kích thước
FROM maven:3.9-eclipse-temurin-17 AS build

# Metadata
LABEL maintainer="Coffee Shop Management Team"
LABEL description="Coffee Shop Management System với DDD và Clean Architecture"

# Tạo thư mục ứng dụng
WORKDIR /app

# Copy pom.xml trước để tận dụng Docker layer caching
COPY pom.xml ./

# Download dependencies (sẽ được cache nếu pom.xml không thay đổi)
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build ứng dụng
RUN mvn clean package -DskipTests -B

# Production stage với JRE only
FROM eclipse-temurin:17-jre-alpine

# Tạo user non-root để chạy ứng dụng (bảo mật)
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

# Tạo thư mục ứng dụng
WORKDIR /app

# Copy JAR file từ build stage
COPY --from=build /app/target/coffee-management-*.jar app.jar

# Tạo thư mục cho logs
RUN mkdir -p /app/logs && chown -R appuser:appgroup /app

# Chuyển sang user non-root
USER appuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/actuator/health || exit 1

# Chạy ứng dụng
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE:docker}", \
    "-jar", \
    "app.jar"]

