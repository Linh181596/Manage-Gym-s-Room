# Gym Center Management System (GCMS)

Hệ thống quản lý vận hành phòng tập Gym chuyên nghiệp thế hệ mới (GCMS) là ứng dụng Web-based được phát triển nhằm tối ưu hóa các quy trình từ quản lý thành viên, huấn luyện viên cá nhân (PT), lịch học, thiết bị phòng tập đến theo dõi doanh thu và báo cáo tổng quan.

---

## 🚀 Hướng Dẫn Bắt Đầu (Getting Started)

### 📋 Yêu cầu hệ thống (Prerequisites)
- **Java Development Kit (JDK):** Phiên bản 11+ (Khuyến nghị sử dụng JDK 21).
- **Apache Maven:** Dùng để quản lý dependencies và đóng gói dự án.
- **Web Server:** Apache Tomcat (tương thích Jakarta EE 10, ví dụ Tomcat 10+).
- **Database:** Microsoft SQL Server.
- **IDE:** Apache NetBeans, IntelliJ IDEA, hoặc Eclipse.

### 🛠️ Các bước thiết lập dự án
1. **Clone project** từ repository về máy cá nhân:
   ```bash
   git clone https://gitlab.com/linhnthe181596/manage-gym.git
   ```
2. **Cấu hình Database:**
   - Tạo database `GymCenterDB` trên SQL Server.
   - Chạy các script SQL khởi tạo trong thư mục tài liệu để tạo bảng và nạp dữ liệu mẫu.
3. **Cấu hình kết nối cơ sở dữ liệu:**
   - Mở file cấu hình kết nối tại: `GymCenterManagement/src/main/resources/db.properties`
   - Điều chỉnh các thông số kết nối phù hợp với máy của bạn:
     ```properties
     db.url=jdbc:sqlserver://localhost:1433;databaseName=GymCenterDB;encrypt=true;trustServerCertificate=true;
     db.username=your_username
     db.password=your_password
     ```
4. **Build dự án bằng Maven:**
   ```bash
   cd GymCenterManagement
   mvn clean install
   ```
5. **Chạy ứng dụng:**
   - Deploy file `.war` được sinh ra trong thư mục `target/` lên Tomcat Server thông qua IDE hoặc giao diện quản trị của Tomcat.
   - Truy cập trang chủ tại: `http://localhost:8080/GymCenterManagement/`

---

## 📐 Kiến Trúc Hệ Thống (Architecture)

GCMS được thiết kế theo mô hình **3-Layer Architecture** kết hợp với mẫu thiết kế **MVC Pattern** cho tầng hiển thị:

```
┌────────────────────────────────────────────────────────┐
│                  CLIENT (Web Browser)                  │
│             HTML / CSS / JS / Bootstrap 5              │
└───────────────────────────┬────────────────────────────┘
                            │ HTTP Requests
                            ▼
┌────────────────────────────────────────────────────────┐
│          SERVLET CONTAINER (Tomcat/GlassFish)          │
│                                                        │
│  [Filter Chain]                                        │
│    ├── EncodingFilter (UTF-8)                          │
│    └── AuthenticationFilter (RBAC)                     │
│                                                        │
│  [Presentation/Controller Layer]                       │
│    └── Servlets (Login, Logout, Dashboards, etc.)      │
│                                                        │
│  [Service Layer - Business Logic]                      │
│    └── UserService → UserServiceImpl                   │
│                                                        │
│  [DAO Layer - Data Access Object]                      │
│    └── BaseDAO → UserDAO → UserDAOImpl                 │
└───────────────────────────┬────────────────────────────┘
                            │ JDBC Connection
                            ▼
┌────────────────────────────────────────────────────────┐
│                  MICROSOFT SQL SERVER                  │
│                 Database: GymCenterDB                  │
└────────────────────────────────────────────────────────┘
```

### 💻 Công nghệ sử dụng (Technology Stack)
- **Backend:** Jakarta EE 10 (Servlet, JSP, JSTL, Taglibs).
- **Database Driver:** Microsoft JDBC Driver for SQL Server.
- **Frontend Template:** DashMin (dựa trên Bootstrap 5, Chart.js, TempusDominus Datepicker).
- **Icons:** Font Awesome 5 + Bootstrap Icons.

Để biết chi tiết về sơ đồ tuần tự đăng nhập, sơ đồ quan hệ class và thiết kế DB, vui lòng tham khảo tài liệu [architecture.md](file:///c:/Projects/%5BJava%5D/Servlet/manage-gym/GymCenterManagement/documentations/architecture.md).

---

## 📂 Cấu Trúc Thư Mục Chính (Directory Structure)

```text
GymCenterManagement/
├── pom.xml                                ← File cấu hình Maven Dependencies
├── src/
│   └── main/
│       ├── java/
│       │   └── com/mycompany/gymcentermanagement/
│       │       ├── controller/            ← [Tầng 1] Servlet xử lý Request & Mapping URL
│       │       ├── service/               ← [Tầng 2] Tầng nghiệp vụ (Business Logic)
│       │       ├── dao/                   ← [Tầng 3] Tầng truy vấn DB (JDBC)
│       │       ├── model/                 ← Các Entity class & Enum quản lý trạng thái
│       │       ├── filter/                ← Bộ lọc mã hóa (Encoding) và phân quyền (RBAC)
│       │       └── utils/                 ← Các class tiện ích (DB connection, Hash Passwords)
│       ├── resources/
│       │   └── db.properties              ← Cấu hình thông tin tài khoản Database SQL Server
│       └── webapp/
│           ├── css/ & js/ & img/          ← Các tài nguyên tĩnh giao diện
│           └── WEB-INF/
│               ├── web.xml                ← Deployment Descriptor cấu hình ứng dụng
│               └── views/                 ← Các view JSP (Common layouts, auth, dashboards)
└── documentations/                        ← Thư mục chứa tài liệu đặc tả dự án
```

---

## 🛠️ Quy Tắc Làm Việc Nhóm & Coding Convention

Để đảm bảo code của tất cả thành viên đồng bộ, chất lượng cao và không xảy ra xung đột khi merge, toàn bộ đội ngũ phát triển bắt buộc tuân thủ quy tắc sau:

### 1. ✍️ Quy tắc ghi công tác giả ở đầu file (File Ownership Comment)
Mọi file mã nguồn mới được tạo ra hoặc chỉnh sửa nhiều bởi thành viên nào thì thành viên đó phải thêm phần mô tả quyền sở hữu ở dòng đầu tiên:

- **Dành cho Java, CSS, JS:**
  ```java
  /**
   * =========================================================================
   * @file          : PtDashboardController.java
   * @description   : Quản lý các view điều phối của PT
   * @author        : Nguyễn Văn A
   * @created       : 2026-05-28
   * @last_modified : 2026-05-28 bởi Nguyễn Văn A
   * =========================================================================
   */
  ```
- **Dành cho JSP:**
  ```jsp
  <%-- 
    =========================================================================
    Document    : dashboard_footer.jsp
    Created on  : 2026-05-28
    Author      : Nguyễn Văn A
    Description : Footer chung chứa thư viện script của dashboard
    =========================================================================
  --%>
  ```

### 2. 🔀 Quy tắc Commit Git (Conventional Commits)
Thông điệp commit phải tuân thủ đúng cấu trúc: `<type>(<scope>): <nội dung commit>`
- **`feat`**: Thêm tính năng mới (ví dụ: `feat(auth): tich hop trang login demo`).
- **`fix`**: Sửa lỗi hệ thống (ví dụ: `fix(equipment): sua loi hien thi ngay mua thiet bi`).
- **`docs`**: Cập nhật tài liệu, README (ví dụ: `docs(readme): cap nhat huong dan lam viec nhom`).
- **`style`**: Định dạng code, sửa khoảng trắng, thụt lề (không đổi logic).
- **`refactor`**: Tái cấu trúc, cải tiến code cũ (không sửa lỗi/không thêm tính năng).
- **`chore`**: Cập nhật build-tool, cấu hình Maven, sửa `.gitignore`.

*Lưu ý:* Luôn code trên nhánh cá nhân dạng `feature/<tên-tính-năng>`, sau đó tạo Pull Request (PR) merge vào nhánh tích hợp chung `dev`. Tuyệt đối không commit trực tiếp lên `dev` hoặc `main`.

### 3. 📜 Quy chuẩn viết mã nguồn (Coding Conventions)
- **Java:** Viết hoa chữ đầu PascalCase cho Class/Interface; viết camelCase cho biến và phương thức; viết hoa toàn bộ và phân cách dấu gạch dưới UPPER_SNAKE_CASE cho Hằng số.
- **Clean Code:** Độ dài phương thức tối đa 50 dòng. Ưu tiên sử dụng return sớm (Guard Clauses) thay vì lồng `if-else` quá 3 cấp. Bắt ngoại lệ phải log rõ ràng (không để trống block `catch`).
- **Frontend/JSP:** Cấm sử dụng scriptlet Java `<% ... %>` trên JSP. Bắt buộc dùng JSTL/EL. Căn lề code sử dụng **4 spaces** nhất quán.

Xem thông tin chi tiết đầy đủ tại file hướng dẫn quy tắc: [development_guidelines.md](file:///c:/Projects/%5BJava%5D/Servlet/manage-gym/GymCenterManagement/documentations/development_guidelines.md).

---

## 📖 Tài Liệu Tham Khảo (Documentations)

Các tài liệu phân tích thiết kế chi tiết khác nằm trong thư mục [documentations/](file:///c:/Projects/%5BJava%5D/Servlet/manage-gym/GymCenterManagement/documentations):
- 📐 Phân tích thiết kế cấu trúc chi tiết: [architecture.md](file:///c:/Projects/%5BJava%5D/Servlet/manage-gym/GymCenterManagement/documentations/architecture.md)
- 📝 Danh sách Use Cases của hệ thống: [GCM UseCases List.md](file:///c:/Projects/%5BJava%5D/Servlet/manage-gym/GymCenterManagement/documentations/GCM%20UseCases%20List.md)
- 📋 Đặc tả yêu cầu phần mềm chi tiết (SRS): [SRS Document.md](file:///c:/Projects/%5BJava%5D/Servlet/manage-gym/GymCenterManagement/documentations/SRS%20Document.md)
- 🎨 Đặc tả giao diện UI/UX và Style Guide dự án: [ui_ux_design.md](file:///c:/Projects/%5BJava%5D/Servlet/manage-gym/GymCenterManagement/documentations/UI%20&%20UX%20documentations/ui_ux_design.md)
