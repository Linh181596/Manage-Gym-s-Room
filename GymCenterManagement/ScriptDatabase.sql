USE [master]
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'GymCenterManagement')
BEGIN
    ALTER DATABASE [GymCenterManagement] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [GymCenterManagement];
END
GO
/****** Object:  Database [GymCenterManagement]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[EquipmentIssues]    Script Date: 6/26/2026 2:58:07 AM ******/
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
	[IssueImageURL] [varchar](255) NULL,
 CONSTRAINT [PK_EquipmentIssues] PRIMARY KEY CLUSTERED 
(
	[IssueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipments]    Script Date: 6/26/2026 2:58:07 AM ******/
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
	[EquipmentType] [nvarchar](50) NULL,
 CONSTRAINT [PK_Equipments] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GymPackages]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[Invoices]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[MemberPackages]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[Members]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[Notifications]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[PersonalTrainers]    Script Date: 6/26/2026 2:58:07 AM ******/
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
	[AvatarPath] [nvarchar](255) NULL,
 CONSTRAINT [PK_PersonalTrainers] PRIMARY KEY CLUSTERED 
(
	[PTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTPackageTypes]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[PTRegistrations]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[PTSchedules]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[PTServicePrices]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[Staffs]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[User_Tokens]    Script Date: 6/26/2026 2:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Tokens](
	[TokenID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[TokenValue] [varchar](255) NOT NULL,
	[TokenType] [varchar](50) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[ExpiresAt] [datetime2](7) NOT NULL,
	[IsUsed] [bit] NOT NULL,
 CONSTRAINT [PK_User_Tokens] PRIMARY KEY CLUSTERED 
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 6/26/2026 2:58:07 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 6/26/2026 2:58:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Phone] [varchar](10) NULL,
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
SET IDENTITY_INSERT [dbo].[Equipments] ON 

INSERT [dbo].[Equipments] ([EquipmentID], [EquipmentCode], [EquipmentName], [PurchaseDate], [WarrantyDate], [Location], [ImageURL], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [EquipmentType]) VALUES (1, N'eq-treadmill-01', N'Máy chạy bộ Matrix T50', CAST(N'2025-01-10' AS Date), CAST(N'2027-01-10' AS Date), N'Khu Cardio', N'/img/treadmill.jpg', N'Available', N'System', CAST(N'2026-05-31T18:27:47.4909757' AS DateTime2), NULL, NULL, 0, N'Khac')
INSERT [dbo].[Equipments] ([EquipmentID], [EquipmentCode], [EquipmentName], [PurchaseDate], [WarrantyDate], [Location], [ImageURL], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [EquipmentType]) VALUES (2, N'eq-benchpress-01', N'Ghế tập ngực Bench Press', CAST(N'2025-01-15' AS Date), CAST(N'2028-01-15' AS Date), N'Khu tập tạ tự do', N'/img/benchpress.jpg', N'Available', N'System', CAST(N'2026-05-31T18:27:47.4909757' AS DateTime2), NULL, NULL, 0, N'Khac')
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
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-20T09:30:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, 1, 2, NULL, 1, CAST(1200000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-20T15:45:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-21T10:15:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, 1, 2, NULL, 3, CAST(1200000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-21T18:20:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (7, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-22T08:00:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (8, 1, 2, NULL, 4, CAST(1200000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-23T14:10:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (9, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-23T19:30:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (10, 1, 2, NULL, 5, CAST(1200000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-24T11:05:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (11, 1, 2, 1, NULL, CAST(800000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-25T10:00:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (12, 1, 2, NULL, 6, CAST(1100000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-25T16:50:00.000' AS DateTime2), N'Paid', N'System', SYSDATETIME(), NULL, NULL, 0)

SET IDENTITY_INSERT [dbo].[Invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[MemberPackages] ON 

INSERT [dbo].[MemberPackages] ([MemberPackageID], [MemberID], [PackageID], [StartDate], [EndDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 1, 1, CAST(N'2026-05-01' AS Date), CAST(N'2026-06-01' AS Date), N'Active', N'System', CAST(N'2026-05-31T18:27:47.4782421' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[MemberPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 4, N'Male', CAST(N'2000-01-01' AS Date), N'Hà Nội', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4538048' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 12, N'Nam', CAST(N'2004-10-22' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-09T10:51:16.1071091' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1002, 1013, N'Nam', CAST(N'2004-10-22' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-12T07:48:15.9443539' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1003, 1014, N'Nam', CAST(N'2004-05-17' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-12T07:50:16.0118158' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1004, 1024, N'Nam', CAST(N'2004-10-22' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-25T10:03:26.5753400' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Members] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 

INSERT [dbo].[Notifications] ([NotificationID], [Title], [Content], [CreatedBy], [TargetRole], [CreatedByRole], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Chào mừng đến với GCMS!', N'Hệ thống quản lý phòng tập Gym Center đã đi vào hoạt động. Trải nghiệm ngay nhé.', 1, N'All', N'Admin', CAST(N'2026-05-31T18:27:47.4935847' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[PersonalTrainers] ON 

INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (1, 3, N'Thể hình (Bodybuilding), Giảm cân', N'Huấn luyện viên thể hình chuyên nghiệp với 5 năm kinh nghiệm.', N'Inactive', N'System', CAST(N'2026-05-31T18:27:47.4644128' AS DateTime2), NULL, NULL, 0, CAST(N'2021-06-03' AS Date), NULL, NULL, N'Personal Trainer', N'Personal Trainer', NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (2, 5, N'Quản lý cân nặng', N'Chuyên hỗ trợ hội viên giảm cân, kiểm soát mỡ và xây dựng thói quen tập luyện bền vững.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8270224' AS DateTime2), NULL, NULL, 0, CAST(N'2022-06-03' AS Date), NULL, NULL, N'Trần Minh Quân', N'Trần Minh Quân', NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (3, 6, N'Tăng cơ', N'Có kinh nghiệm huấn luyện tăng cơ, cải thiện sức mạnh và xây dựng form tập an toàn.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-22T10:10:24.3833333' AS DateTime2), 0, CAST(N'2024-06-14' AS Date), N'Nguyen_Hoang_Nam_TangCo_cer.png', N'assets/uploads/pt-certificate/Nguyen_Hoang_Nam_TangCo_cer.png', N'Nguyễn Hoàng Nam', N'Nguyễn Hoàng Nam', N'')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (4, 7, N'Cardio', N'Hỗ trợ cải thiện sức bền, tim mạch và xây dựng lịch tập cardio phù hợp thể trạng.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-22T09:42:55.7266667' AS DateTime2), 0, CAST(N'2023-06-03' AS Date), NULL, NULL, N'Lê Anh Khoa', N'Anh Khoa Cardio', N'assets/uploads/pt-avatar/1781854280477_Anh_Khoa_update.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (5, 8, N'Tăng cơ, Yoga', N'Chuyên hướng dẫn yoga, cải thiện độ linh hoạt, giảm căng thẳng và phục hồi cơ thể.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-22T10:09:29.7966667' AS DateTime2), 0, CAST(N'2026-06-03' AS Date), N'', N'', N'Phạm Gia Huy', N'Phạm Gia Huy', N'')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (6, 9, N'Boxing', N'Huấn luyện boxing cơ bản đến nâng cao, cải thiện phản xạ, thể lực và kỹ thuật đấm.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0, CAST(N'2022-06-03' AS Date), NULL, NULL, N'Vũ Đức Long', N'Vũ Đức Long', N'assets/uploads/pt-avatar/vu_duc_long_boxing.png')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (7, 10, N'Dinh dưỡng', N'Chuyên hỗ trợ học viên xây dựng chế độ dinh dưỡng phù hợp với mục tiêu tập luyện, đặc biệt là tăng cơ, giảm mỡ và duy trì sức khỏe. Tư vấn thực đơn cân bằng calories, dễ áp dụng và theo dõi tiến độ để giúp học viên đạt kết quả tốt hơn. Chúc mọi người tập luyện vui vẻ! d', N'Active', N'Demo Admin', CAST(N'2026-06-06T11:03:10.7033333' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-26T02:30:18.2066667' AS DateTime2), 0, CAST(N'2022-11-07' AS Date), N'', N'', N'Nguyễn Trọng Đức Huy', N'Coach Huy DD', N'assets/uploads/pt-avatar/1782415780592_Coach_huy_update.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (8, 11, N'Quản lý cân nặng', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-07T09:38:41.5166667' AS DateTime2), NULL, NULL, 0, CAST(N'2025-06-02' AS Date), NULL, NULL, N'Test1', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (9, 1012, N'Yoga', N'Chuyên hướng dẫn Yoga & Linh hoạt, hỗ trợ học viên cải thiện độ dẻo dai, tư thế, thăng bằng và kiểm soát hơi thở. Phù hợp cho người mới bắt đầu hoặc người muốn tập luyện nhẹ nhàng, an toàn và đều đặn.', N'Active', N'Demo Admin', CAST(N'2026-06-09T11:56:50.6200000' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-26T02:35:17.4100000' AS DateTime2), 0, CAST(N'2024-02-15' AS Date), N'Nguyen_Thi_Nga_Yoga_cer', N'assets/uploads/pt-certificate/Nguyen_Thi_Nga_Yoga_cer.png', N'Nguyễn Thị Nga', N'Nga Yoga', N'assets/uploads/pt-avatar/Nguyen_Thi_Nga_Yoga.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (10, 1015, N'Quản lý cân nặng', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:14:03.7333333' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-11' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (11, 1016, N'Quản lý cân nặng', N'âfafaf', N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:19:51.3066667' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-11' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (12, 1017, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:40:41.5600000' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-07' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (13, 1018, N'Tăng cơ', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:45:42.0800000' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-07' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (14, 1019, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:51:48.5033333' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-01' AS Date), NULL, NULL, N'TestPTduplicate4', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (15, 1020, N'Yoga', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:57:37.3666667' AS DateTime2), NULL, NULL, 0, CAST(N'2026-03-17' AS Date), NULL, NULL, N'TestPTduplicate5', N'Coach DuplicatePhone', NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (16, 1021, N'Phục hồi thể lực', N'Tự tin là 1 PT giỏi trong lĩnh vực phục hồi thể lực! 
Sẽ giúp bạn có giây phút healing sau buổi tập căng thẳng. Chúc các bạn sớm có người yêu', N'Active', N'Demo Admin', CAST(N'2026-06-14T00:01:55.0133333' AS DateTime2), N'coachviet_phtl@gmail.com', CAST(N'2026-06-26T02:31:59.5466667' AS DateTime2), 0, CAST(N'2026-06-20' AS Date), N'Tran_Quoc_Viet.png', N'assets/uploads/pt-certificate/Tran_Quoc_Viet.png', N'Trần Quốc Việt', N'Coach Việt', N'assets/uploads/pt-avatar/1782415919541_Coach_Viet_Update.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (17, 1022, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-14T01:12:37.1966667' AS DateTime2), NULL, NULL, 0, CAST(N'2025-07-10' AS Date), NULL, NULL, N'Trần Quốc Việt', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (18, 1023, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-14T01:32:29.4566667' AS DateTime2), NULL, NULL, 0, CAST(N'2025-07-10' AS Date), NULL, NULL, N'Trần Quốc Gia', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (19, 2024, N'Dinh dưỡng', N'', N'Active', N'Demo Staff', CAST(N'2026-06-26T01:07:41.9833333' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-26T02:32:44.9266667' AS DateTime2), 0, CAST(N'2026-06-12' AS Date), N'', N'', N'TestSyncLockedPT', NULL, N'')
SET IDENTITY_INSERT [dbo].[PersonalTrainers] OFF
GO
SET IDENTITY_INSERT [dbo].[PTPackageTypes] ON 

INSERT [dbo].[PTPackageTypes] ([PTPackageTypeID], [PackageName], [Description], [DurationMonths], [NumberOfSessions], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Gói PT Cơ bản 1 Tháng', N'Huấn luyện tiêu chuẩn trong 1 tháng với PT.', 1, 12, N'Active', N'System', CAST(N'2026-05-31T18:27:47.4670592' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTPackageTypes] ([PTPackageTypeID], [PackageName], [Description], [DurationMonths], [NumberOfSessions], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'Gói PT Cao cấp 3 Tháng', N'Huấn luyện cao cấp trong 3 tháng với PT.', 3, 36, N'Active', N'System', CAST(N'2026-05-31T18:27:47.4670592' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[PTPackageTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[PTRegistrations] ON 

INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (1, 1, 1, CAST(N'2026-06-01' AS Date), CAST(N'2026-06-01' AS Date), CAST(N'2026-06-30' AS Date), N'Cancelled', N'Đăng ký lần đầu | Lý do h?y: PT đã bị inactive', N'System', CAST(N'2026-05-31T18:27:47.4802560' AS DateTime2), N'Gym Administrator', CAST(N'2026-06-25T00:14:24.6449208' AS DateTime2), 0, CAST(1200000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-25T00:14:24.6449208' AS DateTime2))
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (3, 1, 1, CAST(N'2026-06-01' AS Date), CAST(N'2026-06-01' AS Date), CAST(N'2026-07-01' AS Date), N'Cancelled', N'Tôi muốn nhanh chóng giảm cân
Tôi muốn thử trước 1 tháng | Lý do h?y: PT đã bị Inactive', N'System', CAST(N'2026-06-01T15:51:29.7900382' AS DateTime2), N'Gym Administrator', CAST(N'2026-06-25T00:14:37.5037305' AS DateTime2), 0, CAST(1200000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-25T00:14:37.5037305' AS DateTime2))
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (4, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Active', N'Tôi muốn giảm cân, hãy xếp lịch tập sớm cho tôi', N'System', CAST(N'2026-06-02T04:38:48.7290377' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (5, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Active', N'Tôi thực sự muốn giảm cân. Bạn bè bảo tôi quá béo, tôi rất tự ti.', N'System', CAST(N'2026-06-02T04:39:23.1548789' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (6, 1, 7, CAST(N'2026-06-10' AS Date), CAST(N'2026-06-10' AS Date), CAST(N'2026-07-09' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-07T09:42:34.2420419' AS DateTime2), NULL, NULL, 0, CAST(1100000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (7, 1, 11, CAST(N'2026-06-15' AS Date), CAST(N'2026-06-15' AS Date), CAST(N'2026-07-14' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-14T00:08:42.3140381' AS DateTime2), NULL, NULL, 0, CAST(1350000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (8, 1, 8, CAST(N'2026-06-26' AS Date), CAST(N'2026-06-26' AS Date), CAST(N'2026-09-25' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-24T15:23:02.6051048' AS DateTime2), NULL, NULL, 0, CAST(2970000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (9, 1004, 4, CAST(N'2026-07-01' AS Date), NULL, NULL, N'Cancelled', N'Khởi đầu tháng mới tôi muốn tập giữ cân nặng của tôi cho tới tháng 12 để đi đi thi boxing mức cân 60kg. | Lý do h?y: PT quá bận', N'Nguyễn Đình Phú', CAST(N'2026-06-25T10:16:40.4264412' AS DateTime2), N'Demo Staff', CAST(N'2026-06-26T02:46:08.4461538' AS DateTime2), 0, CAST(3240000.00 AS Decimal(12, 2)), N'Cancelled', 2, CAST(N'2026-06-26T02:46:08.4461538' AS DateTime2))
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (10, 1004, 11, CAST(N'2026-07-03' AS Date), CAST(N'2026-07-03' AS Date), CAST(N'2026-08-02' AS Date), N'Active', N'Tôi muốn tập boxing để tự vệ khỏi hater.', N'Nguyễn Đình Phú', CAST(N'2026-06-25T11:20:21.0196660' AS DateTime2), NULL, NULL, 0, CAST(1350000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (11, 1004, 12, CAST(N'2026-07-01' AS Date), CAST(N'2026-07-01' AS Date), CAST(N'2026-09-30' AS Date), N'Cancelled', N'Tôi muốn tập boxing ca sáng
 | Lý do h?y: PT bận vkl', N'Nguyễn Đình Phú', CAST(N'2026-06-25T12:15:14.4783089' AS DateTime2), N'Demo Admin', CAST(N'2026-06-25T12:15:56.9338719' AS DateTime2), 0, CAST(3645000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-25T12:15:56.9338719' AS DateTime2))
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt]) VALUES (1009, 1, 7, CAST(N'2026-06-25' AS Date), CAST(N'2026-06-25' AS Date), CAST(N'2026-07-24' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-25T23:47:33.3218669' AS DateTime2), NULL, NULL, 0, CAST(1100000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL)
SET IDENTITY_INSERT [dbo].[PTRegistrations] OFF
GO
SET IDENTITY_INSERT [dbo].[PTSchedules] ON 

INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (61, 6, 4, 1, CAST(N'2026-06-29' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3466667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (62, 6, 4, 1, CAST(N'2026-07-06' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (63, 6, 4, 1, CAST(N'2026-07-13' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (64, 6, 4, 1, CAST(N'2026-07-20' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (65, 6, 4, 1, CAST(N'2026-07-27' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (66, 6, 4, 1, CAST(N'2026-08-03' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (67, 6, 4, 1, CAST(N'2026-08-10' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (68, 6, 4, 1, CAST(N'2026-08-17' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (69, 6, 4, 1, CAST(N'2026-08-24' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (70, 6, 4, 1, CAST(N'2026-08-31' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (71, 6, 4, 1, CAST(N'2026-09-07' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (72, 6, 4, 1, CAST(N'2026-09-14' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3533333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (73, 6, 4, 1, CAST(N'2026-06-30' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (74, 6, 4, 1, CAST(N'2026-07-07' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (75, 6, 4, 1, CAST(N'2026-07-14' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (76, 6, 4, 1, CAST(N'2026-07-21' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (77, 6, 4, 1, CAST(N'2026-07-28' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (78, 6, 4, 1, CAST(N'2026-08-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (79, 6, 4, 1, CAST(N'2026-08-11' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (80, 6, 4, 1, CAST(N'2026-08-18' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (81, 6, 4, 1, CAST(N'2026-08-25' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (82, 6, 4, 1, CAST(N'2026-09-01' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (83, 6, 4, 1, CAST(N'2026-09-08' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (84, 6, 4, 1, CAST(N'2026-09-15' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (85, 6, 4, 1, CAST(N'2026-07-01' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9166667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (86, 6, 4, 1, CAST(N'2026-07-08' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9166667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (87, 6, 4, 1, CAST(N'2026-07-15' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (88, 6, 4, 1, CAST(N'2026-07-22' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (89, 6, 4, 1, CAST(N'2026-07-29' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (90, 6, 4, 1, CAST(N'2026-08-05' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (91, 6, 4, 1, CAST(N'2026-08-12' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (92, 6, 4, 1, CAST(N'2026-08-19' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (93, 6, 4, 1, CAST(N'2026-08-26' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (94, 6, 4, 1, CAST(N'2026-09-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (95, 6, 4, 1, CAST(N'2026-09-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9266667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (96, 6, 4, 1, CAST(N'2026-09-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9266667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (97, 8, 4, 1, CAST(N'2026-07-02' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5333333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (98, 8, 4, 1, CAST(N'2026-07-03' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5333333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (99, 8, 4, 1, CAST(N'2026-07-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (100, 8, 4, 1, CAST(N'2026-07-09' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (101, 8, 4, 1, CAST(N'2026-07-10' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (102, 8, 4, 1, CAST(N'2026-07-11' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (103, 8, 4, 1, CAST(N'2026-07-16' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (104, 8, 4, 1, CAST(N'2026-07-17' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (105, 8, 4, 1, CAST(N'2026-07-18' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (106, 8, 4, 1, CAST(N'2026-07-23' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (107, 8, 4, 1, CAST(N'2026-07-24' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (108, 8, 4, 1, CAST(N'2026-07-25' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (109, 8, 4, 1, CAST(N'2026-07-30' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (110, 8, 4, 1, CAST(N'2026-07-31' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (111, 8, 4, 1, CAST(N'2026-08-01' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (112, 8, 4, 1, CAST(N'2026-08-06' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (113, 8, 4, 1, CAST(N'2026-08-07' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (114, 8, 4, 1, CAST(N'2026-08-08' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (115, 8, 4, 1, CAST(N'2026-08-13' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (116, 8, 4, 1, CAST(N'2026-08-14' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (117, 8, 4, 1, CAST(N'2026-08-15' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (118, 8, 4, 1, CAST(N'2026-08-20' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (119, 8, 4, 1, CAST(N'2026-08-21' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (120, 8, 4, 1, CAST(N'2026-08-22' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (121, 8, 4, 1, CAST(N'2026-08-27' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (122, 8, 4, 1, CAST(N'2026-08-28' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (123, 8, 4, 1, CAST(N'2026-08-29' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (124, 8, 4, 1, CAST(N'2026-09-03' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (125, 8, 4, 1, CAST(N'2026-09-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (126, 8, 4, 1, CAST(N'2026-09-05' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (127, 8, 4, 1, CAST(N'2026-09-10' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (128, 8, 4, 1, CAST(N'2026-09-11' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (129, 8, 4, 1, CAST(N'2026-09-12' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (130, 8, 4, 1, CAST(N'2026-09-17' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (131, 8, 4, 1, CAST(N'2026-09-18' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (132, 8, 4, 1, CAST(N'2026-09-19' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (133, 7, 6, 1, CAST(N'2026-06-30' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (134, 7, 6, 1, CAST(N'2026-07-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (135, 7, 6, 1, CAST(N'2026-07-03' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (136, 7, 6, 1, CAST(N'2026-07-07' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (137, 7, 6, 1, CAST(N'2026-07-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (138, 7, 6, 1, CAST(N'2026-07-10' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (139, 7, 6, 1, CAST(N'2026-07-14' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (140, 7, 6, 1, CAST(N'2026-07-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (141, 7, 6, 1, CAST(N'2026-07-17' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (142, 7, 6, 1, CAST(N'2026-07-21' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (143, 7, 6, 1, CAST(N'2026-07-23' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (144, 7, 6, 1, CAST(N'2026-07-24' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (145, 4, 2, 1, CAST(N'2026-06-25' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0466667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (146, 4, 2, 1, CAST(N'2026-06-26' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0466667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (147, 4, 2, 1, CAST(N'2026-07-01' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (148, 4, 2, 1, CAST(N'2026-07-02' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (149, 4, 2, 1, CAST(N'2026-07-03' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (150, 4, 2, 1, CAST(N'2026-07-08' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (151, 4, 2, 1, CAST(N'2026-07-09' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (152, 4, 2, 1, CAST(N'2026-07-10' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (153, 4, 2, 1, CAST(N'2026-07-15' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (154, 4, 2, 1, CAST(N'2026-07-16' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (155, 4, 2, 1, CAST(N'2026-07-17' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (156, 4, 2, 1, CAST(N'2026-07-22' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (169, 9, 2, 1004, CAST(N'2026-07-03' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0000000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (170, 9, 2, 1004, CAST(N'2026-07-04' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0033333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (171, 9, 2, 1004, CAST(N'2026-07-10' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0100000' AS DateTime2), NULL, NULL, 0)
GO
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (172, 9, 2, 1004, CAST(N'2026-07-11' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0100000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (173, 9, 2, 1004, CAST(N'2026-07-17' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (174, 9, 2, 1004, CAST(N'2026-07-18' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (175, 9, 2, 1004, CAST(N'2026-07-24' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (176, 9, 2, 1004, CAST(N'2026-07-25' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (177, 9, 2, 1004, CAST(N'2026-07-31' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (178, 9, 2, 1004, CAST(N'2026-08-01' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (179, 9, 2, 1004, CAST(N'2026-08-07' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (180, 9, 2, 1004, CAST(N'2026-08-08' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (181, 9, 2, 1004, CAST(N'2026-08-14' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (182, 9, 2, 1004, CAST(N'2026-08-15' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (183, 9, 2, 1004, CAST(N'2026-08-21' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (184, 9, 2, 1004, CAST(N'2026-08-22' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (185, 9, 2, 1004, CAST(N'2026-08-28' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (186, 9, 2, 1004, CAST(N'2026-08-29' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (187, 9, 2, 1004, CAST(N'2026-09-04' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (188, 9, 2, 1004, CAST(N'2026-09-05' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (189, 9, 2, 1004, CAST(N'2026-09-11' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (190, 9, 2, 1004, CAST(N'2026-09-12' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (191, 9, 2, 1004, CAST(N'2026-09-18' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (192, 9, 2, 1004, CAST(N'2026-09-19' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (193, 9, 2, 1004, CAST(N'2026-09-25' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (194, 9, 2, 1004, CAST(N'2026-09-26' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (195, 9, 2, 1004, CAST(N'2026-10-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (196, 9, 2, 1004, CAST(N'2026-10-03' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (197, 9, 2, 1004, CAST(N'2026-10-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (198, 9, 2, 1004, CAST(N'2026-10-10' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (199, 9, 2, 1004, CAST(N'2026-10-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (200, 9, 2, 1004, CAST(N'2026-10-17' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (201, 9, 2, 1004, CAST(N'2026-10-23' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (202, 9, 2, 1004, CAST(N'2026-10-24' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (203, 9, 2, 1004, CAST(N'2026-10-30' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (204, 9, 2, 1004, CAST(N'2026-10-31' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T10:17:20.0133333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1169, 1009, 4, 1, CAST(N'2026-06-25' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Completed', N'Attended', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9633333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1170, 1009, 4, 1, CAST(N'2026-06-26' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9633333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1171, 1009, 4, 1, CAST(N'2026-06-29' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1172, 1009, 4, 1, CAST(N'2026-07-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1173, 1009, 4, 1, CAST(N'2026-07-03' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1174, 1009, 4, 1, CAST(N'2026-07-06' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1175, 1009, 4, 1, CAST(N'2026-07-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1176, 1009, 4, 1, CAST(N'2026-07-10' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1177, 1009, 4, 1, CAST(N'2026-07-13' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1178, 1009, 4, 1, CAST(N'2026-07-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1179, 1009, 4, 1, CAST(N'2026-07-17' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1180, 1009, 4, 1, CAST(N'2026-07-20' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1181, 10, 6, 1004, CAST(N'2026-07-03' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9733333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1182, 10, 6, 1004, CAST(N'2026-07-06' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9766667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1183, 10, 6, 1004, CAST(N'2026-07-08' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1184, 10, 6, 1004, CAST(N'2026-07-10' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1185, 10, 6, 1004, CAST(N'2026-07-13' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1186, 10, 6, 1004, CAST(N'2026-07-15' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1187, 10, 6, 1004, CAST(N'2026-07-17' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1188, 10, 6, 1004, CAST(N'2026-07-20' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1189, 10, 6, 1004, CAST(N'2026-07-22' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1190, 10, 6, 1004, CAST(N'2026-07-24' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1191, 10, 6, 1004, CAST(N'2026-07-27' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1192, 10, 6, 1004, CAST(N'2026-07-29' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-26T02:41:37.9833333' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[PTSchedules] OFF
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
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (13, 7, 1, CAST(999000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T01:10:44.6266667' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (14, 7, 2, CAST(2700000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T01:10:44.6300000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (15, 19, 1, CAST(0.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T02:14:58.2533333' AS DateTime2), N'System', CAST(N'2026-06-26T02:25:10.1166667' AS DateTime2), 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (16, 19, 2, CAST(0.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T02:14:58.2533333' AS DateTime2), N'System', CAST(N'2026-06-26T02:25:10.1200000' AS DateTime2), 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (17, 9, 1, CAST(1500000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T02:33:34.0800000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (18, 9, 2, CAST(4200000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T02:33:34.0833333' AS DateTime2), NULL, NULL, 0)
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
SET IDENTITY_INSERT [dbo].[User_Tokens] ON 

INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (1, 12, N'6f848a95-403e-4aa6-8aa3-f001f2f515fe', N'VERIFICATION', CAST(N'2026-06-09T10:51:16.1112407' AS DateTime2), CAST(N'2026-06-10T10:51:16.0763519' AS DateTime2), 0)
INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (2, 1013, N'79e1b34a-e8a2-4f95-b4c8-50797f949e32', N'VERIFICATION', CAST(N'2026-06-12T07:48:15.9478538' AS DateTime2), CAST(N'2026-06-13T07:48:15.9080088' AS DateTime2), 0)
INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (3, 1014, N'f275d1de-f0e1-4732-9d6c-fbbd3ea307d7', N'VERIFICATION', CAST(N'2026-06-12T07:50:16.0128766' AS DateTime2), CAST(N'2026-06-13T07:50:15.9967988' AS DateTime2), 0)
INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (7, 1024, N'41f17404-fd24-4e6d-a555-19d54975c17d', N'VERIFICATION', CAST(N'2026-06-25T10:03:26.5807895' AS DateTime2), CAST(N'2026-06-26T10:03:26.5497413' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[User_Tokens] OFF
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1, 1)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (2, 2)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (3, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (5, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (6, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (7, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (8, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (9, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (10, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (11, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1012, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1015, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1016, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1017, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1018, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1019, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1020, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1021, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1022, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1023, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (2024, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (4, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (12, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1013, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1014, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1024, 4)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'admin@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Gym Administrator', N'0912345678', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'staff@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Staff Member', N'0912345679', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, N'pt@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Personal Trainer', N'0912345680', N'Active', 1, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, N'member@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Gym Member', N'0912345681', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, N'pt.quan@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Trần Minh Quân', N'0901000001', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8255136' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, N'pt.nam@gcms.com', N'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', N'Nguyễn Hoàng Nam', N'0901000002', N'Active', 1, N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (7, N'pt.khoa@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Lê Anh Khoa', N'0901000006', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (8, N'pt.huy@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Phạm Gia Huy', N'0901000004', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (9, N'pt.long@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Vũ Đức Long', N'0901000005', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (10, N'huydd@gmail.com', N'a64a02b0ecc1767cd2b932134c7fb00cb6b47bbec32979b99bb64513b54f4195', N'Coach Huy DD', N'0999999999', N'Active', 0, N'Demo Admin', CAST(N'2026-06-06T11:03:10.6620000' AS DateTime2), NULL, CAST(N'2026-06-26T02:30:18.2100000' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (11, N'testpt@gmail.con', N'c1ee98257c924b0e2aae86e715ae4b6fe8b96739a6387b8075e2903e74816042', N'Test1', N'0000000000', N'Active', 0, N'Demo Admin', CAST(N'2026-06-07T09:38:41.4730000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (12, N'phuhocfpt@gmail.com', N'b0f5f5bd0a78188853fde457b835ab7466b15f66667991ef61d72d45d34fd649', N'Nguyễn Đình Phú', N'0559442269', N'Inactive', 0, N'System', CAST(N'2026-06-09T10:51:16.0903641' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1012, N'ngayogapt@gmai.com', N'17f24e7c13cd44029457d4f14cb67d435d853d75ccbe8d9eedfa9dd310fdceb3', N'Nga Yoga', N'0987986435', N'Active', 1, N'Demo Admin', CAST(N'2026-06-09T11:56:50.5990000' AS DateTime2), NULL, CAST(N'2026-06-26T02:35:17.4100000' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1013, N'nhasi1110@gmail.com', N'b0f5f5bd0a78188853fde457b835ab7466b15f66667991ef61d72d45d34fd649', N'Nguyễn Đình Phú', N'0559442269', N'Inactive', 0, N'System', CAST(N'2026-06-12T07:48:15.9281849' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1014, N'nguyentrilinh2004@gmail.com', N'efd191441e48fc51e7cd7ee3b5621ecde769240e9438e980c84e46a895181444', N'Nguyễn Trí Linh', N'0123659843', N'Inactive', 0, N'System', CAST(N'2026-06-12T07:50:16.0096844' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1015, N'testpt@gmail.com', N'eb146dabbe1ae89ec3a7957cd6cec902a803f42b9d161118fb0e0068f849de7f', N'TestPTduplicate', N'0000000000', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:14:03.7020000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1016, N'come@gmail.com', N'37b41a5d4a5105e6e9427e951811dc77ea736c470c93f07b2c747656a03b87a8', N'TestPTduplicate', N'0000000000', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:19:51.2970000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1017, N'testduplicatephone@gmail.com', N'354266efb4713f6fedd096f550fce5ee1048f696178cd97706b23368a827c723', N'TestPTduplicate', N'0999999999', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:40:41.5460000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1018, N'testduplicatephone_1@gmail.com', N'f4f1dace5e29364f34eff5ba6ff83bd09808d0a88c6fcc1fc9817364eda27502', N'TestPTduplicate', N'0912345680', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:45:42.0730000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1019, N'testduplicatephone_4@gmail.com', N'c50f235901398bba3aea4b8f65a3986335a518f97ca407ac3be24aa8cf8e1281', N'TestPTduplicate4', N'0901000001', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:51:48.4900000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1020, N'testduplicatephone_5@gmail.com', N'8ca0506fac88d10138d61174083b0e34b6e400cfa959bd5da456a05437ac92f1', N'Coach DuplicatePhone', N'0901000001', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:57:37.3580000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1021, N'coachviet_phtl@gmail.com', N'00650ae6b819d1af2d2db529cb693428f4e2175bb746b143718d15d29495ae9c', N'Trần Quốc Việt', N'0124579641', N'Active', 0, N'Demo Admin', CAST(N'2026-06-14T00:01:54.9910000' AS DateTime2), NULL, CAST(N'2026-06-18T17:58:16.0548873' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1022, N'coachviet_phtldd@gmail.conme', N'278904f8cfcb27a835a51a1b5a81572448a3adaa53e3d7740afb5f3c160b33cd', N'Trần Quốc Việt', N'0124579632', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-14T01:12:37.1640000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1023, N'coachviet_phtldd@gmail.conmecsff', N'5773b0f3afcc874b1d9eae06e933e01ad0674afd104c22a05c19d9b3c04a8dab', N'Trần Quốc Gia', N'0124579632', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-14T01:32:29.4460000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1024, N'phundhe181315@fpt.edu.vn', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Nguyễn Đình Phú', N'0102030908', N'Active', 0, N'System', CAST(N'2026-06-25T10:03:26.5569284' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2024, N'lockedptsync@lockedptsync.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'TestSyncLockedPT', N'0147852236', N'Active', 0, N'Demo Staff', CAST(N'2026-06-26T01:07:41.9663468' AS DateTime2), NULL, CAST(N'2026-06-26T02:32:44.9300000' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_EquipmentIssues_Equipment_Status]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_EquipmentIssues_Equipment_Status] ON [dbo].[EquipmentIssues]
(
	[EquipmentID] ASC
)
INCLUDE([Status],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Equipments_Code]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[Equipments] ADD  CONSTRAINT [UQ_Equipments_Code] UNIQUE NONCLUSTERED 
(
	[EquipmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Invoices_ForeignKeys]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Invoices_ForeignKeys] ON [dbo].[Invoices]
(
	[MemberID] ASC
)
INCLUDE([MemberPackageID],[PTRegistrationID],[Status],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MemberPackages_Member_Package]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_MemberPackages_Member_Package] ON [dbo].[MemberPackages]
(
	[MemberID] ASC,
	[PackageID] ASC
)
INCLUDE([StartDate],[EndDate],[Status],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Members_UserID]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[Members] ADD  CONSTRAINT [UQ_Members_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Members_Status_Deleted]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Members_Status_Deleted] ON [dbo].[Members]
(
	[MembershipStatus] ASC,
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PT_UserID]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[PersonalTrainers] ADD  CONSTRAINT [UQ_PT_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PersonalTrainers_Status_Deleted]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_PersonalTrainers_Status_Deleted] ON [dbo].[PersonalTrainers]
(
	[Status] ASC,
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PTRegistrations_Member_Price]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_PTRegistrations_Member_Price] ON [dbo].[PTRegistrations]
(
	[MemberID] ASC,
	[PTServicePriceID] ASC
)
INCLUDE([Status],[PaymentStatus],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PTSchedules_Slot]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[PTSchedules] ADD  CONSTRAINT [UQ_PTSchedules_Slot] UNIQUE NONCLUSTERED 
(
	[PTID] ASC,
	[SessionDate] ASC,
	[StartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PTSchedules_Member_Reg]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_PTSchedules_Member_Reg] ON [dbo].[PTSchedules]
(
	[MemberID] ASC,
	[PTRegistrationID] ASC
)
INCLUDE([SessionStatus],[PTAttendanceResult],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PTServicePrices_PT_Package]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[PTServicePrices] ADD  CONSTRAINT [UQ_PTServicePrices_PT_Package] UNIQUE NONCLUSTERED 
(
	[PTID] ASC,
	[PTPackageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PTServicePrices_Status_Deleted]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_PTServicePrices_Status_Deleted] ON [dbo].[PTServicePrices]
(
	[Status] ASC,
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Roles_Name]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [UQ_Roles_Name] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Staffs_UserID]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[Staffs] ADD  CONSTRAINT [UQ_Staffs_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User_Tok__FE1B80EC6AEF774C]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[User_Tokens] ADD UNIQUE NONCLUSTERED 
(
	[TokenValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRoles_RoleID]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleID] ON [dbo].[UserRoles]
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 6/26/2026 2:58:07 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_Status_Deleted]    Script Date: 6/26/2026 2:58:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_Status_Deleted] ON [dbo].[Users]
(
	[Status] ASC,
	[IsDeleted] ASC
)
INCLUDE([Email],[DisplayName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[User_Tokens] ADD  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[User_Tokens] ADD  DEFAULT ((0)) FOR [IsUsed]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_MustChangePassword]  DEFAULT ((0)) FOR [MustChangePassword]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_CreatedDate]  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
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
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [FK_PTRegistrations_ProcessedByUser] FOREIGN KEY([ProcessedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [FK_PTRegistrations_ProcessedByUser]
GO
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [FK_PTRegistrations_ServicePrices] FOREIGN KEY([PTServicePriceID])
REFERENCES [dbo].[PTServicePrices] ([PTServicePriceID])
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [FK_PTRegistrations_ServicePrices]
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
ALTER TABLE [dbo].[User_Tokens]  WITH CHECK ADD  CONSTRAINT [FK_UserTokens_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Tokens] CHECK CONSTRAINT [FK_UserTokens_Users]
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
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [CK_PTRegistrations_PaymentStatus] CHECK  (([PaymentStatus]='Cancelled' OR [PaymentStatus]='Paid' OR [PaymentStatus]='Unpaid'))
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [CK_PTRegistrations_PaymentStatus]
GO
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [CK_PTRegistrations_Status] CHECK  (([Status]='Cancelled' OR [Status]='Completed' OR [Status]='Active' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [CK_PTRegistrations_Status]
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
ALTER TABLE [dbo].[User_Tokens]  WITH CHECK ADD  CONSTRAINT [CK_UserTokens_Type] CHECK  (([TokenType]='REMEMBER_ME' OR [TokenType]='RESET_PASSWORD' OR [TokenType]='VERIFICATION'))
GO
ALTER TABLE [dbo].[User_Tokens] CHECK CONSTRAINT [CK_UserTokens_Type]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [CK_Users_Status] CHECK  (([Status]='Locked' OR [Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [CK_Users_Status]
GO
USE [master]
GO
ALTER DATABASE [GymCenterManagement] SET  READ_WRITE 
GO

USE [GymCenterManagement]
GO

-- =========================================================================
-- Table: MaintenanceSchedules
-- =========================================================================
CREATE TABLE [dbo].[MaintenanceSchedules](
	[MaintenanceScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NOT NULL,
	[IssueID] [int] NULL,
	[ScheduledDate] [date] NOT NULL,
	[MaintenanceType] [varchar](20) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[CompletionDate] [datetime2](7) NULL,
	[CompletionNote] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MaintenanceSchedules] PRIMARY KEY CLUSTERED 
(
	[MaintenanceScheduleID] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_MaintenanceSchedules_Search] ON [dbo].[MaintenanceSchedules]
(
	[Status] ASC,
	[ScheduledDate] DESC,
	[EquipmentID] ASC
)
INCLUDE([MaintenanceType],[IssueID],[IsDeleted])
GO

CREATE UNIQUE NONCLUSTERED INDEX [UQ_MaintenanceSchedules_Equipment_Date_Active] ON [dbo].[MaintenanceSchedules]
(
	[EquipmentID] ASC,
	[ScheduledDate] ASC
)
WHERE ([IsDeleted]=(0) AND [Status]<>'Cancelled')
GO

ALTER TABLE [dbo].[MaintenanceSchedules] ADD CONSTRAINT [DF_MaintenanceSchedules_Status] DEFAULT ('Scheduled') FOR [Status]
GO
ALTER TABLE [dbo].[MaintenanceSchedules] ADD CONSTRAINT [DF_MaintenanceSchedules_CreatedDate] DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[MaintenanceSchedules] ADD CONSTRAINT [DF_MaintenanceSchedules_IsDeleted] DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[MaintenanceSchedules] WITH CHECK ADD CONSTRAINT [FK_MaintenanceSchedules_Equipments] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipments] ([EquipmentID])
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [FK_MaintenanceSchedules_Equipments]
GO

ALTER TABLE [dbo].[MaintenanceSchedules] WITH CHECK ADD CONSTRAINT [FK_MaintenanceSchedules_EquipmentIssues] FOREIGN KEY([IssueID])
REFERENCES [dbo].[EquipmentIssues] ([IssueID])
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [FK_MaintenanceSchedules_EquipmentIssues]
GO

ALTER TABLE [dbo].[MaintenanceSchedules] WITH CHECK ADD CONSTRAINT [CK_MaintenanceSchedules_Status]
CHECK (([Status]='Scheduled' OR [Status]='InProgress' OR [Status]='Completed' OR [Status]='Cancelled'))
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [CK_MaintenanceSchedules_Status]
GO

ALTER TABLE [dbo].[MaintenanceSchedules] WITH CHECK ADD CONSTRAINT [CK_MaintenanceSchedules_Type]
CHECK (([MaintenanceType]='Preventive' OR [MaintenanceType]='Corrective'))
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [CK_MaintenanceSchedules_Type]
GO
