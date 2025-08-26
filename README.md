# Coffee Shop Management System

Hệ thống quản lý quán cà phê được xây dựng với Spring Boot, áp dụng Domain-Driven Design (DDD) và Clean Architecture.

## Cấu trúc dự án

```
src/main/java/com/coffeeshop/management/
├── domain/                           # Domain Layer (Business Logic)
│   ├── entities/                     # Domain Entities
│   ├── valueobjects/                # Value Objects
│   ├── repositories/                # Repository Interfaces
│   ├── services/                    # Domain Services
│   └── events/                      # Domain Events & Event Processing
│       ├── handlers/                # Domain Event Handlers
│       └── publishers/              # Domain Event Publishers
├── application/                     # Application Layer (Use Cases)
│   ├── usecases/                    # Use Cases/Interactors
│   ├── dtos/                        # Application DTOs
│   ├── mappers/                     # Mappers
│   ├── services/                    # Application Services
│   ├── eventhandlers/               # Application Event Handlers
│   └── sagas/                       # Saga Orchestrators (Distributed Transactions)
├── infrastructure/                  # Infrastructure Layer (External Concerns)
│   ├── repositories/                # Repository Implementations
│   ├── persistence/
│   │   ├── entities/                # JPA Entities
│   │   └── mappers/                 # Persistence Mappers
│   ├── external/                    # External Service Integrations
│   ├── configurations/              # Infrastructure Configurations
│   └── events/                      # Event Infrastructure
│       ├── store/                   # Event Store Implementation
│       ├── messaging/               # Message Broker Integration (Kafka)
│       ├── outbox/                  # Outbox Pattern Implementation
│       ├── projections/             # Event Projections (Read Models)
│       └── snapshots/               # Event Sourcing Snapshots
└── presentation/                    # Presentation Layer (Controllers)
    ├── controllers/                 # REST Controllers
    ├── dtos/
    │   ├── requests/                # Request DTOs
    │   └── responses/               # Response DTOs
    ├── configurations/              # Web Configurations
    └── exceptions/                  # Exception Handlers
```

## Công nghệ sử dụng

### Core Framework
- **Java 17**
- **Spring Boot 3.2.1**
- **Spring Data JPA**
- **Spring Security**

### Event-Driven Architecture
- **Apache Kafka** - Message Streaming Platform
- **Axon Framework** - Event Sourcing & CQRS
- **Redis** - Event Store & Caching

### Database
- **PostgreSQL** (Docker environment)
- **H2** (Development/Testing)

### Utilities
- **Lombok** - Reduce Boilerplate Code
- **MapStruct** - Object Mapping
- **SpringDoc OpenAPI** - API Documentation (Swagger)

## 🚀 Cài đặt và chạy dự án

### 📋 Yêu cầu hệ thống
- **Docker & Docker Compose** (khuyến nghị)
- Java 17+ (nếu chạy local)
- Maven 3.6+ (nếu chạy local)

### 🐳 Chạy với Docker (Khuyến nghị - CHỈ CẦN 1 LỆNH)

#### **Khởi động toàn bộ hệ thống:**
```bash
docker-compose up -d
```

#### **Dừng toàn bộ hệ thống:**
```bash
docker-compose down
```

#### **Xem logs của ứng dụng:**
```bash
# Xem logs Coffee Management App
docker logs coffee-management-app --tail 50 -f

# Xem logs tất cả services
docker-compose logs -f --tail=10
```

#### **Kiểm tra trạng thái containers:**
```bash
docker-compose ps
```

### 🌐 **Thông tin truy cập sau khi khởi động:**

| Service | URL | Mô tả | Credentials |
|---------|-----|-------|-------------|
| **Coffee Management API** | http://localhost:8090/api | Main application API | - |
| **Swagger UI** | http://localhost:8090/api/swagger-ui.html | API Documentation | - |
| **Health Check** | http://localhost:8090/api/actuator/health | Application health | - |
| **Keycloak Admin** | http://localhost:8080 | Authentication server | admin/admin123 |
| **Kafka UI** | http://localhost:8088 | Kafka management | - |
| **Redis Commander** | http://localhost:8081 | Redis management | - |
| **Axon Server** | http://localhost:8124 | Event store dashboard | - |

### 🔧 **Khởi động lại sau khi tắt máy:**

Khi bạn khởi động lại máy tính, chỉ cần chạy:
```bash
docker-compose up -d
```

**Lưu ý:** Đợi khoảng 30-60 giây để tất cả services khởi động hoàn tất.

### 💻 **Chạy local với profile DEV (Hybrid approach)**

#### ✅ **Infrastructure trên Docker + Application local**

**Profile `dev` kết hợp:**
- **Infrastructure services**: Chạy trên Docker (PostgreSQL, Redis, Kafka, Axon Server, Keycloak)
- **Application**: Chạy local trên IDE với enhanced debugging

#### Các bước:
1. **Khởi động infrastructure services:**
   ```bash
   docker-compose up -d postgres redis kafka zookeeper axonserver keycloak kafka-ui redis-commander
   ```

2. **Cài đặt dependencies:**
   ```bash
   mvn clean install
   ```

3. **Chạy application với profile dev:**
   ```bash
   mvn spring-boot:run -Dspring-boot.run.profiles=dev
   ```

#### **Hoặc chạy từ IDE:**
- **IntelliJ**: Set VM options: `-Dspring.profiles.active=dev`
- **VS Code**: Set environment variable: `SPRING_PROFILES_ACTIVE=dev`

#### **Development URLs:**
- **Coffee Management API**: http://localhost:8080/api
- **Swagger**: http://localhost:8080/api/swagger-ui.html
- **Keycloak Admin**: http://localhost:8080 (admin/admin123)
- **Kafka UI**: http://localhost:8088
- **Redis Commander**: http://localhost:8081
- **Axon Server**: http://localhost:8124

#### **Lợi ích của approach này:**
- ✅ **Full debugging** capabilities trong IDE
- ✅ **Hot reload** khi thay đổi code
- ✅ **Enhanced logging** và detailed SQL tracing
- ✅ **Sử dụng infrastructure thật** (PostgreSQL, Redis, Kafka)
- ✅ **Consistent với Docker environment**

### 🏢 **Chạy local với infrastructure đầy đủ (Tùy chọn)**

#### Yêu cầu:
- PostgreSQL server chạy local
- Redis server chạy local  
- Kafka server chạy local
- Axon Server chạy local

#### Các bước:
1. Clone repository
2. Cấu hình database trong `application.yml`
3. Cài đặt dependencies:
   ```bash
   mvn clean install
   ```
4. Chạy ứng dụng:
   ```bash
   mvn spring-boot:run
   ```

### 🛠️ **Troubleshooting**

#### Nếu có lỗi container name conflict:
```bash
docker-compose down
docker system prune -f
docker-compose up -d
```

#### Nếu database connection failed:
- Kiểm tra PostgreSQL container đang chạy: `docker ps | findstr postgres`
- Xem logs PostgreSQL: `docker logs postgres`

#### Nếu port đã được sử dụng:
```bash
# Kiểm tra process sử dụng port 8090
netstat -ano | findstr :8090

# Dừng container cũ
docker stop coffee-management-app
docker rm coffee-management-app
```

## Nguyên tắc thiết kế

### Domain-Driven Design (DDD)
- **Domain Layer**: Chứa business logic và domain models
- **Application Layer**: Orchestrates domain objects để thực hiện use cases
- **Infrastructure Layer**: Implementations của interfaces được định nghĩa trong domain
- **Presentation Layer**: Handles HTTP requests và responses

### Clean Architecture
- **Dependency Rule**: Dependencies chỉ point inward
- **Independence**: Business logic không phụ thuộc vào framework, UI, database
- **Testability**: Business logic có thể test mà không cần external dependencies

### Event-Driven Architecture
- **Event Sourcing**: Lưu trữ state changes dưới dạng events
- **CQRS**: Tách biệt Command và Query models
- **Saga Pattern**: Quản lý distributed transactions
- **Outbox Pattern**: Đảm bảo eventual consistency
- **Event Projections**: Tạo read models từ event stream
- **Snapshots**: Tối ưu hóa event replay

## Cấu hình

### 🗄️ Database Configuration
- **Docker Environment**: PostgreSQL (`coffe_management` database)
- **Development**: H2 in-memory database  
- **Production**: PostgreSQL

### 🔄 Event Infrastructure
- **Kafka**: Message streaming (localhost:9092)
- **Redis**: Event store và caching (localhost:6379)
- **Axon Framework**: Event sourcing và CQRS

### 🔐 Security & Authentication
- **Keycloak**: OAuth2/JWT authentication server
- **Spring Security**: Role-based authorization
- **JWT**: Stateless authentication

### 📊 Monitoring & Observability
- **Health Checks**: Spring Actuator endpoints
- **Swagger UI**: API documentation
- **Logging**: Structured logging với multiple levels
- **Event Tracing**: Distributed tracing với Axon
- **Metrics**: Application metrics via Actuator

### 🐳 Docker Services
| Service | Port | Description |
|---------|------|-------------|
| coffee-management-app | 8090 | Main Spring Boot application |
| postgres | 5432 | PostgreSQL database |
| redis | 6379 | Redis cache/session store |
| kafka | 9092 | Apache Kafka message broker |
| zookeeper | 2181 | Kafka coordination service |
| axonserver | 8024/8124 | Axon event store |
| keycloak | 8080 | Authentication server |
| kafka-ui | 8088 | Kafka management UI |
| redis-commander | 8081 | Redis management UI |
