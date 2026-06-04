USE [master]
GO
/****** Object:  Database [GymCenterManagement]    Script Date: 5/31/2026 10:18:12 PM ******/
CREATE DATABASE [GymCenterManagement]
GO
ALTER DATABASE [GymCenterManagement] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GymCenterManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GymCenterManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GymCenterManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GymCenterManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GymCenterManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GymCenterManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [GymCenterManagement] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [GymCenterManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GymCenterManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GymCenterManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GymCenterManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GymCenterManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GymCenterManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GymCenterManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GymCenterManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GymCenterManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GymCenterManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GymCenterManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GymCenterManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GymCenterManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GymCenterManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GymCenterManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GymCenterManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GymCenterManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GymCenterManagement] SET  MULTI_USER 
GO
ALTER DATABASE [GymCenterManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GymCenterManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GymCenterManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GymCenterManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GymCenterManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GymCenterManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GymCenterManagement] SET QUERY_STORE = ON
GO
ALTER DATABASE [GymCenterManagement] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GymCenterManagement]
GO
/****** Object:  Table [dbo].[EquipmentIssues]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentIssues](
	[IssueID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NOT NULL,
	[ReportedBy] [int] NOT NULL,
	[IssueType] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ReportedAt] [datetime2](7) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_EquipmentIssues] PRIMARY KEY CLUSTERED 
(
	[IssueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipments]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipments](
	[EquipmentID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentCode] [varchar](50) NOT NULL,
	[EquipmentName] [nvarchar](100) NOT NULL,
	[PurchaseDate] [date] NOT NULL,
	[WarrantyDate] [date] NULL,
	[Location] [nvarchar](100) NULL,
	[ImageURL] [varchar](255) NULL,
	[Status] [varchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Equipments] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GymPackages]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GymPackages](
	[PackageID] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [nvarchar](100) NOT NULL,
	[DurationMonths] [int] NOT NULL,
	[Price] [decimal](12, 2) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_GymPackages] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NOT NULL,
	[ProcessBy] [int] NOT NULL,
	[MemberPackageID] [int] NULL,
	[PTRegistrationID] [int] NULL,
	[Amount] [decimal](12, 2) NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[PaymentDate] [datetime2](7) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberPackages]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberPackages](
	[MemberPackageID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NOT NULL,
	[PackageID] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MemberPackages] PRIMARY KEY CLUSTERED 
(
	[MemberPackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Gender] [varchar](10) NULL,
	[DateOfBirth] [date] NULL,
	[Address] [nvarchar](255) NULL,
	[MembershipStatus] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[TargetRole] [varchar](50) NOT NULL,
	[CreatedByRole] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonalTrainers]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonalTrainers](
	[PTID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Specialization] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CareerStartDate] [date] NOT NULL,
	[CertificateFileName] [nvarchar](255) NULL,
	[CertificateFilePath] [nvarchar](255) NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NULL,
 CONSTRAINT [PK_PersonalTrainers] PRIMARY KEY CLUSTERED 
(
	[PTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTPackageTypes]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PTPackageTypes](
	[PTPackageTypeID] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[DurationMonths] [int] NOT NULL,
	[NumberOfSessions] [int] NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PTPackageTypes] PRIMARY KEY CLUSTERED 
(
	[PTPackageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTRegistrations]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PTRegistrations](
	[PTRegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NOT NULL,
	[PTServicePriceID] [int] NOT NULL,
	[PreferredStartDate] [date] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Status] [varchar](20) NOT NULL,
	[Note] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TotalAmount] [decimal](12, 2) NOT NULL,
	[PaymentStatus] [varchar](20) NOT NULL,
	[ProcessedByUserID] [int] NULL,
	[ProcessedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_PTRegistrations] PRIMARY KEY CLUSTERED 
(
	[PTRegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTSchedules]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PTSchedules](
	[PTScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[PTRegistrationID] [int] NOT NULL,
	[PTID] [int] NOT NULL,
	[MemberID] [int] NOT NULL,
	[SessionDate] [date] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[SessionStatus] [varchar](20) NOT NULL,
	[PTAttendanceResult] [varchar](20) NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PTSchedules] PRIMARY KEY CLUSTERED 
(
	[PTScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTServicePrices]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PTServicePrices](
	[PTServicePriceID] [int] IDENTITY(1,1) NOT NULL,
	[PTID] [int] NOT NULL,
	[PTPackageTypeID] [int] NOT NULL,
	[Price] [decimal](12, 2) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PTServicePrices] PRIMARY KEY CLUSTERED 
(
	[PTServicePriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[RoleLevel] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staffs]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staffs](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Position] [nvarchar](100) NULL,
	[Status] [varchar](20) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Staffs] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/31/2026 10:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Phone] [varchar](15) NULL,
	[Status] [varchar](20) NOT NULL,
	[MustChangePassword] [bit] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[User_Tokens](
	[TokenID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Token] [varchar](255) NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Equipments] ON 

INSERT [dbo].[Equipments] ([EquipmentID], [EquipmentCode], [EquipmentName], [PurchaseDate], [WarrantyDate], [Location], [ImageURL], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'eq-treadmill-01', N'Máy chạy bộ Matrix T50', CAST(N'2025-01-10' AS Date), CAST(N'2027-01-10' AS Date), N'Khu Cardio', N'/img/treadmill.jpg', N'Available', N'System', CAST(N'2026-05-31T18:27:47.4909757' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Equipments] ([EquipmentID], [EquipmentCode], [EquipmentName], [PurchaseDate], [WarrantyDate], [Location], [ImageURL], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'eq-benchpress-01', N'Ghế tập ngực Bench Press', CAST(N'2025-01-15' AS Date), CAST(N'2028-01-15' AS Date), N'Khu tập tạ tự do', N'/img/benchpress.jpg', N'Available', N'System', CAST(N'2026-05-31T18:27:47.4909757' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Equipments] OFF
GO
SET IDENTITY_INSERT [dbo].[GymPackages] ON 

INSERT [dbo].[GymPackages] ([PackageID], [PackageName], [DurationMonths], [Price], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Gói Gym Cơ bản 1 Tháng', 1, CAST(300000.00 AS Decimal(12, 2)), N'Gói tập gym tiêu chuẩn trong 1 tháng.', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4753462' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[GymPackages] ([PackageID], [PackageName], [DurationMonths], [Price], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'Gói Gym Cao cấp 3 Tháng', 3, CAST(800000.00 AS Decimal(12, 2)), N'Gói tập gym tiêu chuẩn trong 3 tháng.', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4753462' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[GymPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoices] ON 

INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 1, 1, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-05-01T00:00:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-05-31T18:27:47.4884214' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 1, 1, NULL, 1, CAST(1200000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-05-31T00:00:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-05-31T18:27:47.4884214' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[MemberPackages] ON 

INSERT [dbo].[MemberPackages] ([MemberPackageID], [MemberID], [PackageID], [StartDate], [EndDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 1, 1, CAST(N'2026-05-01' AS Date), CAST(N'2026-06-01' AS Date), N'Active', N'System', CAST(N'2026-05-31T18:27:47.4782421' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[MemberPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 4, N'Male', CAST(N'2000-01-01' AS Date), N'Hà Nội', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4538048' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Members] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 

INSERT [dbo].[Notifications] ([NotificationID], [Title], [Content], [CreatedBy], [TargetRole], [CreatedByRole], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Chào mừng đến với GCMS!', N'Hệ thống quản lý phòng tập Gym Center đã đi vào hoạt động. Trải nghiệm ngay nhé.', 1, N'All', N'Admin', CAST(N'2026-05-31T18:27:47.4935847' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[PersonalTrainers] ON 

INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName]) VALUES (1, 3, N'Thể hình (Bodybuilding), Giảm cân', N'Huấn luyện viên thể hình chuyên nghiệp với 5 năm kinh nghiệm.', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4644128' AS DateTime2), NULL, NULL, 0, CAST(N'2021-06-03' AS Date), NULL, NULL, N'Personal Trainer', N'Personal Trainer')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName]) VALUES (2, 5, N'Quản lý cân nặng', N'Chuyên hỗ trợ hội viên giảm cân, kiểm soát mỡ và xây dựng thói quen tập luyện bền vững.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8270224' AS DateTime2), NULL, NULL, 0, CAST(N'2022-06-03' AS Date), NULL, NULL, N'Trần Minh Quân', N'Trần Minh Quân')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName]) VALUES (3, 6, N'Tăng cơ', N'Có kinh nghiệm huấn luyện tăng cơ, cải thiện sức mạnh và xây dựng form tập an toàn.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0, CAST(N'2021-06-03' AS Date), NULL, NULL, N'Nguyễn Hoàng Nam', N'Nguyễn Hoàng Nam')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName]) VALUES (4, 7, N'Cardio', N'Hỗ trợ cải thiện sức bền, tim mạch và xây dựng lịch tập cardio phù hợp thể trạng.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0, CAST(N'2023-06-03' AS Date), NULL, NULL, N'Lê Anh Khoa', N'Lê Anh Khoa')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName]) VALUES (5, 8, N'Yoga', N'Chuyên hướng dẫn yoga, cải thiện độ linh hoạt, giảm căng thẳng và phục hồi cơ thể.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0, CAST(N'2020-06-03' AS Date), NULL, NULL, N'Phạm Gia Huy', N'Phạm Gia Huy')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName]) VALUES (6, 9, N'Boxing', N'Huấn luyện boxing cơ bản đến nâng cao, cải thiện phản xạ, thể lực và kỹ thuật đấm.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0, CAST(N'2022-06-03' AS Date), NULL, NULL, N'Vũ Đức Long', N'Vũ Đức Long')
SET IDENTITY_INSERT [dbo].[PersonalTrainers] OFF
GO
SET IDENTITY_INSERT [dbo].[PTPackageTypes] ON 

INSERT [dbo].[PTPackageTypes] ([PTPackageTypeID], [PackageName], [Description], [DurationMonths], [NumberOfSessions], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Gói PT Cơ bản 1 Tháng', N'Huấn luyện tiêu chuẩn trong 1 tháng với PT.', 1, 12, N'Active', N'System', CAST(N'2026-05-31T18:27:47.4670592' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTPackageTypes] ([PTPackageTypeID], [PackageName], [Description], [DurationMonths], [NumberOfSessions], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'Gói PT Cao cấp 3 Tháng', N'Huấn luyện cao cấp trong 3 tháng với PT.', 3, 36, N'Active', N'System', CAST(N'2026-05-31T18:27:47.4670592' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[PTPackageTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[PTRegistrations] ON 

INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (1, 1, 1, CAST(N'2026-06-01' AS Date), CAST(N'2026-06-01' AS Date), CAST(N'2026-06-30' AS Date), N'Pending', N'Đăng ký lần đầu', N'System', CAST(N'2026-05-31T18:27:47.4802560' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (3, 1, 1, CAST(N'2026-06-01' AS Date), CAST(N'2026-06-01' AS Date), CAST(N'2026-07-01' AS Date), N'Pending', N'Tôi muốn nhanh chóng giảm cân
Tôi muốn thử trước 1 tháng', N'System', CAST(N'2026-06-01T15:51:29.7900382' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (4, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Pending', N'Tôi muốn giảm cân, hãy xếp lịch tập sớm cho tôi', N'System', CAST(N'2026-06-02T04:38:48.7290377' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (5, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Pending', N'Tôi thực sự muốn giảm cân. Bạn bè bảo tôi quá béo, tôi rất tự ti.', N'System', CAST(N'2026-06-02T04:39:23.1548789' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL)
SET IDENTITY_INSERT [dbo].[PTRegistrations] OFF
GO
SET IDENTITY_INSERT [dbo].[PTServicePrices] ON 

INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 1, 1, CAST(1200000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-05-31T18:27:47.4721924' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 1, 2, CAST(3200000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-05-31T18:27:47.4721924' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, 2, 1, CAST(1200000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8270224' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, 2, 2, CAST(3240000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8270224' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, 3, 1, CAST(1400000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, 3, 2, CAST(3780000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (7, 4, 1, CAST(1100000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (8, 4, 2, CAST(2970000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (9, 5, 1, CAST(1300000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (10, 5, 2, CAST(3510000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (11, 6, 1, CAST(1350000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (12, 6, 2, CAST(3645000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[PTServicePrices] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Admin', 1, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'Staff', 2, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, N'PT', 3, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, N'Member', 4, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Staffs] ON 

INSERT [dbo].[Staffs] ([StaffID], [UserID], [Position], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 2, N'Receptionist', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4559441' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Staffs] OFF
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1, 1)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (2, 2)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (3, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (4, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (5, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (6, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (7, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (8, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (9, 3)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'admin@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Gym Administrator', N'0912345678', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'staff@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Staff Member', N'0912345679', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, N'pt@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Personal Trainer', N'0912345680', N'Active', 1, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, N'member@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Gym Member', N'0912345681', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, N'pt.quan@gcms.com', N'12345678', N'Trần Minh Quân', N'0901000001', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8255136' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, N'pt.nam@gcms.com', N'12345678', N'Nguyễn Hoàng Nam', N'0901000002', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (7, N'pt.khoa@gcms.com', N'12345678', N'Lê Anh Khoa', N'0901000003', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (8, N'pt.huy@gcms.com', N'12345678', N'Phạm Gia Huy', N'0901000004', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (9, N'pt.long@gcms.com', N'12345678', N'Vũ Đức Long', N'0901000005', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Equipments_Code]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[Equipments] ADD  CONSTRAINT [UQ_Equipments_Code] UNIQUE NONCLUSTERED 
(
	[EquipmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Members_UserID]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[Members] ADD  CONSTRAINT [UQ_Members_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PT_UserID]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[PersonalTrainers] ADD  CONSTRAINT [UQ_PT_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[User_Tokens] ADD UNIQUE NONCLUSTERED 
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PTSchedules_Slot]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[PTSchedules] ADD  CONSTRAINT [UQ_PTSchedules_Slot] UNIQUE NONCLUSTERED 
(
	[PTID] ASC,
	[SessionDate] ASC,
	[StartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PTServicePrices_PT_Package]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[PTServicePrices] ADD  CONSTRAINT [UQ_PTServicePrices_PT_Package] UNIQUE NONCLUSTERED 
(
	[PTID] ASC,
	[PTPackageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Roles_Name]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [UQ_Roles_Name] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Staffs_UserID]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[Staffs] ADD  CONSTRAINT [UQ_Staffs_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 5/31/2026 10:18:13 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EquipmentIssues] ADD  DEFAULT (sysdatetime()) FOR [ReportedAt]
GO
ALTER TABLE [dbo].[EquipmentIssues] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[EquipmentIssues] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Equipments] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Equipments] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[GymPackages] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[GymPackages] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (sysdatetime()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MemberPackages] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[MemberPackages] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Members] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Members] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PersonalTrainers] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PersonalTrainers] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PTPackageTypes] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PTPackageTypes] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PTRegistrations] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PTRegistrations] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PTRegistrations] ADD  CONSTRAINT [DF_PTRegistrations_PaymentStatus]  DEFAULT ('Unpaid') FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[PTSchedules] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PTSchedules] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PTServicePrices] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PTServicePrices] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Staffs] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Staffs] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [MustChangePassword]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[EquipmentIssues]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentIssues_Equipments] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipments] ([EquipmentID])
GO
ALTER TABLE [dbo].[EquipmentIssues] CHECK CONSTRAINT [FK_EquipmentIssues_Equipments]
GO
ALTER TABLE [dbo].[EquipmentIssues]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentIssues_Reporter] FOREIGN KEY([ReportedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[EquipmentIssues] CHECK CONSTRAINT [FK_EquipmentIssues_Reporter]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_MemberPackages] FOREIGN KEY([MemberPackageID])
REFERENCES [dbo].[MemberPackages] ([MemberPackageID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_MemberPackages]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_Members] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Members] ([MemberID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_Members]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_PTRegistrations] FOREIGN KEY([PTRegistrationID])
REFERENCES [dbo].[PTRegistrations] ([PTRegistrationID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_PTRegistrations]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_Users] FOREIGN KEY([ProcessBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_Users]
GO
ALTER TABLE [dbo].[MemberPackages]  WITH CHECK ADD  CONSTRAINT [FK_MemberPackages_GymPackages] FOREIGN KEY([PackageID])
REFERENCES [dbo].[GymPackages] ([PackageID])
GO
ALTER TABLE [dbo].[MemberPackages] CHECK CONSTRAINT [FK_MemberPackages_GymPackages]
GO
ALTER TABLE [dbo].[MemberPackages]  WITH CHECK ADD  CONSTRAINT [FK_MemberPackages_Members] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Members] ([MemberID])
GO
ALTER TABLE [dbo].[MemberPackages] CHECK CONSTRAINT [FK_MemberPackages_Members]
GO
ALTER TABLE [dbo].[Members]  WITH CHECK ADD  CONSTRAINT [FK_Members_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Members] CHECK CONSTRAINT [FK_Members_Users]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Users]
GO

ALTER TABLE [dbo].[PersonalTrainers]  WITH CHECK ADD  CONSTRAINT [FK_PersonalTrainers_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PersonalTrainers] CHECK CONSTRAINT [FK_PersonalTrainers_Users]
GO

ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [FK_PTRegistrations_Members] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Members] ([MemberID])
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [FK_PTRegistrations_Members]
GO
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [FK_PTRegistrations_ServicePrices] FOREIGN KEY([PTServicePriceID])
REFERENCES [dbo].[PTServicePrices] ([PTServicePriceID])
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [FK_PTRegistrations_ServicePrices]
GO
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [FK_PTRegistrations_ProcessedByUser] FOREIGN KEY([ProcessedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [FK_PTRegistrations_ProcessedByUser]
GO
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PTSchedules_Creator] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [FK_PTSchedules_Creator]
GO
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PTSchedules_Members] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Members] ([MemberID])
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [FK_PTSchedules_Members]
GO
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PTSchedules_PT] FOREIGN KEY([PTID])
REFERENCES [dbo].[PersonalTrainers] ([PTID])
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [FK_PTSchedules_PT]
GO
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PTSchedules_Registrations] FOREIGN KEY([PTRegistrationID])
REFERENCES [dbo].[PTRegistrations] ([PTRegistrationID])
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [FK_PTSchedules_Registrations]
GO
ALTER TABLE [dbo].[PTServicePrices]  WITH CHECK ADD  CONSTRAINT [FK_PTServicePrices_PackageType] FOREIGN KEY([PTPackageTypeID])
REFERENCES [dbo].[PTPackageTypes] ([PTPackageTypeID])
GO
ALTER TABLE [dbo].[PTServicePrices] CHECK CONSTRAINT [FK_PTServicePrices_PackageType]
GO
ALTER TABLE [dbo].[PTServicePrices]  WITH CHECK ADD  CONSTRAINT [FK_PTServicePrices_PT] FOREIGN KEY([PTID])
REFERENCES [dbo].[PersonalTrainers] ([PTID])
GO
ALTER TABLE [dbo].[PTServicePrices] CHECK CONSTRAINT [FK_PTServicePrices_PT]
GO
ALTER TABLE [dbo].[Staffs]  WITH CHECK ADD  CONSTRAINT [FK_Staffs_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Staffs] CHECK CONSTRAINT [FK_Staffs_Users]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users]
GO
ALTER TABLE [dbo].[User_Tokens]  WITH CHECK ADD  CONSTRAINT [FK_UserTokens_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Tokens] CHECK CONSTRAINT [FK_UserTokens_Users]
GO
ALTER TABLE [dbo].[EquipmentIssues]  WITH CHECK ADD  CONSTRAINT [CK_EquipmentIssues_Status] CHECK  (([Status]='Resolved' OR [Status]='InProgress' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[EquipmentIssues] CHECK CONSTRAINT [CK_EquipmentIssues_Status]
GO
ALTER TABLE [dbo].[Equipments]  WITH CHECK ADD  CONSTRAINT [CK_Equipments_Status] CHECK  (([Status]='Broken' OR [Status]='Maintenance' OR [Status]='Available'))
GO
ALTER TABLE [dbo].[Equipments] CHECK CONSTRAINT [CK_Equipments_Status]
GO
ALTER TABLE [dbo].[GymPackages]  WITH CHECK ADD  CONSTRAINT [CK_GymPackages_Duration] CHECK  (([DurationMonths]>(0)))
GO
ALTER TABLE [dbo].[GymPackages] CHECK CONSTRAINT [CK_GymPackages_Duration]
GO
ALTER TABLE [dbo].[GymPackages]  WITH CHECK ADD  CONSTRAINT [CK_GymPackages_Price] CHECK  (([Price]>=(0)))
GO
ALTER TABLE [dbo].[GymPackages] CHECK CONSTRAINT [CK_GymPackages_Price]
GO
ALTER TABLE [dbo].[GymPackages]  WITH CHECK ADD  CONSTRAINT [CK_GymPackages_Status] CHECK  (([Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[GymPackages] CHECK CONSTRAINT [CK_GymPackages_Status]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [CK_Invoices_Amount] CHECK  (([Amount]>=(0)))
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [CK_Invoices_Amount]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [CK_Invoices_Status] CHECK  (([Status]='Cancelled' OR [Status]='Pending' OR [Status]='Paid'))
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [CK_Invoices_Status]
GO
ALTER TABLE [dbo].[MemberPackages]  WITH CHECK ADD  CONSTRAINT [CK_MemberPackages_Status] CHECK  (([Status]='Expired' OR [Status]='Active' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[MemberPackages] CHECK CONSTRAINT [CK_MemberPackages_Status]
GO
ALTER TABLE [dbo].[Members]  WITH CHECK ADD  CONSTRAINT [CK_Members_Status] CHECK  (([MembershipStatus]='Pending' OR [MembershipStatus]='Inactive' OR [MembershipStatus]='Active'))
GO
ALTER TABLE [dbo].[Members] CHECK CONSTRAINT [CK_Members_Status]
GO
ALTER TABLE [dbo].[PersonalTrainers]  WITH CHECK ADD  CONSTRAINT [CK_PersonalTrainers_Status] CHECK  (([Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[PersonalTrainers] CHECK CONSTRAINT [CK_PersonalTrainers_Status]
GO
ALTER TABLE [dbo].[PTPackageTypes]  WITH CHECK ADD  CONSTRAINT [CK_PTPackageTypes_Duration] CHECK  (([DurationMonths]>(0)))
GO
ALTER TABLE [dbo].[PTPackageTypes] CHECK CONSTRAINT [CK_PTPackageTypes_Duration]
GO
ALTER TABLE [dbo].[PTPackageTypes]  WITH CHECK ADD  CONSTRAINT [CK_PTPackageTypes_Sessions] CHECK  (([NumberOfSessions]>(0)))
GO
ALTER TABLE [dbo].[PTPackageTypes] CHECK CONSTRAINT [CK_PTPackageTypes_Sessions]
GO
ALTER TABLE [dbo].[PTPackageTypes]  WITH CHECK ADD  CONSTRAINT [CK_PTPackageTypes_Status] CHECK  (([Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[PTPackageTypes] CHECK CONSTRAINT [CK_PTPackageTypes_Status]
GO
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [CK_PTRegistrations_Status] CHECK  (([Status]='Cancelled' OR [Status]='Completed' OR [Status]='Active' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [CK_PTRegistrations_Status]
GO
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [CK_PTRegistrations_PaymentStatus] CHECK  (([PaymentStatus]='Cancelled' OR [PaymentStatus]='Paid' OR [PaymentStatus]='Unpaid'))
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [CK_PTRegistrations_PaymentStatus]
GO
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [CK_PTRegistrations_TotalAmount] CHECK  (([TotalAmount]>=(0)))
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [CK_PTRegistrations_TotalAmount]
GO
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [CK_PTSchedules_Attendance] CHECK  (([PTAttendanceResult]='Absent' OR [PTAttendanceResult]='Attended' OR [PTAttendanceResult]='Pending'))
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [CK_PTSchedules_Attendance]
GO
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [CK_PTSchedules_Status] CHECK  (([SessionStatus]='Cancelled' OR [SessionStatus]='Completed' OR [SessionStatus]='Upcoming'))
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [CK_PTSchedules_Status]
GO
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [CK_PTSchedules_Time] CHECK  (([StartTime]<[EndTime]))
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [CK_PTSchedules_Time]
GO
ALTER TABLE [dbo].[PTServicePrices]  WITH CHECK ADD  CONSTRAINT [CK_PTServicePrices_Price] CHECK  (([Price]>=(0)))
GO
ALTER TABLE [dbo].[PTServicePrices] CHECK CONSTRAINT [CK_PTServicePrices_Price]
GO
ALTER TABLE [dbo].[PTServicePrices]  WITH CHECK ADD  CONSTRAINT [CK_PTServicePrices_Status] CHECK  (([Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[PTServicePrices] CHECK CONSTRAINT [CK_PTServicePrices_Status]
GO
ALTER TABLE [dbo].[Staffs]  WITH CHECK ADD  CONSTRAINT [CK_Staffs_Status] CHECK  (([Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[Staffs] CHECK CONSTRAINT [CK_Staffs_Status]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [CK_Users_Status] CHECK  (([Status]='Locked' OR [Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [CK_Users_Status]
GO
USE [master]
GO
ALTER DATABASE [GymCenterManagement] SET  READ_WRITE 
GO



-- ============================================================
-- GCMS equipment module migrations appended after base script
-- ============================================================

USE [GymCenterManagement]
GO

IF COL_LENGTH('dbo.Equipments', 'EquipmentType') IS NULL
BEGIN
    ALTER TABLE [dbo].[Equipments] ADD [EquipmentType] NVARCHAR(50) NULL;
END
GO

UPDATE [dbo].[Equipments]
SET [EquipmentType] = N'Khac'
WHERE [EquipmentType] IS NULL OR [EquipmentType] = N'Gym';
GO


USE [GymCenterManagement]
GO

IF COL_LENGTH('dbo.EquipmentIssues', 'IssueImageURL') IS NULL
BEGIN
    ALTER TABLE [dbo].[EquipmentIssues] ADD [IssueImageURL] VARCHAR(255) NULL;
END
GO
