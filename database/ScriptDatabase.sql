USE [master]
GO
/****** Object:  Database [GymCenterManagement]    Script Date: 7/8/2026 2:38:41 PM ******/
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'GymCenterManagement')
BEGIN
    ALTER DATABASE [GymCenterManagement] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [GymCenterManagement];
END
GO
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
/****** Object:  Table [dbo].[EquipmentIssues]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[Equipments]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[GymPackages]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[Invoices]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[MaintenanceSchedules]    Script Date: 7/8/2026 2:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[CompletionImageURL] [varchar](255) NULL,
	[SubmittedForApprovalAt] [datetime2](7) NULL,
	[SubmittedBy] [nvarchar](50) NULL,
	[RequestedIssueResolution] [bit] NOT NULL,
	[ApprovedBy] [nvarchar](50) NULL,
	[ApprovedAt] [datetime2](7) NULL,
	[ApprovalNote] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MaintenanceSchedules] PRIMARY KEY CLUSTERED 
(
	[MaintenanceScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberPackages]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[Members]    Script Date: 7/8/2026 2:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Gender] [nvarchar](10) NULL CHECK (Gender IN (N'Nam', N'Nữ', N'Khác') OR Gender IS NULL),
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
/****** Object:  Table [dbo].[NotificationRecipients]    Script Date: 7/8/2026 2:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationRecipients](
	[NotificationRecipientID] [int] IDENTITY(1,1) NOT NULL,
	[NotificationID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[ReadAt] [datetime2](7) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_NotificationRecipients] PRIMARY KEY CLUSTERED 
(
	[NotificationRecipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 7/8/2026 2:38:42 PM ******/
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
	[PublishDate] [datetime2](7) NOT NULL,
	[ExpiryDate] [datetime2](7) NULL,
	[NotificationImageURL] [varchar](255) NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonalTrainers]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[PTPackageTypes]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[PTRegistrations]    Script Date: 7/8/2026 2:38:42 PM ******/
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
	[PurchasedSessions] [int] NOT NULL,
 CONSTRAINT [PK_PTRegistrations] PRIMARY KEY CLUSTERED 
(
	[PTRegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTSchedules]    Script Date: 7/8/2026 2:38:42 PM ******/
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
	[OriginalPTID] [int] NULL,
	[SubstituteReason] [nvarchar](255) NULL,
	[SubstituteByUserID] [int] NULL,
	[SubstituteAt] [datetime2](7) NULL,
	[CancelledByUserID] [int] NULL,
	[CancelledAt] [datetime2](7) NULL,
	[CancellationReason] [nvarchar](255) NULL,
 CONSTRAINT [PK_PTSchedules] PRIMARY KEY CLUSTERED 
(
	[PTScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTServicePrices]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[RescheduleRequests]    Script Date: 7/8/2026 2:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RescheduleRequests](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[PTScheduleID] [int] NOT NULL,
	[SenderUserID] [int] NOT NULL,
	[ReceiverUserID] [int] NOT NULL,
	[OriginalDate] [date] NOT NULL,
	[OriginalStartTime] [time](7) NOT NULL,
	[OriginalEndTime] [time](7) NOT NULL,
	[ProposedDate] [date] NOT NULL,
	[ProposedStartTime] [time](7) NOT NULL,
	[ProposedEndTime] [time](7) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[Reason] [nvarchar](255) NULL,
	[ResponseReason] [nvarchar](255) NULL,
	[RespondedByUserID] [int] NULL,
	[RespondedAt] [datetime2](7) NULL,
	[EscalatedByUserID] [int] NULL,
	[EscalatedAt] [datetime2](7) NULL,
	[EscalationReason] [nvarchar](255) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[StaffPTAttendance]    Script Date: 7/8/2026 2:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffPTAttendance](
	[AttendanceID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[UserRole] [varchar](20) NOT NULL,
	[CheckedInAt] [datetime2](7) NOT NULL,
	[CheckedOutAt] [datetime2](7) NULL,
	[AttendanceDate]  AS (CONVERT([date],[CheckedInAt])) PERSISTED,
	[ShiftBlock] [varchar](20) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[CheckedBy] [int] NOT NULL,
	[Note] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_StaffPTAttendance] PRIMARY KEY CLUSTERED 
(
	[AttendanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staffs]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[User_Tokens]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 7/8/2026 2:38:42 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 7/8/2026 2:38:42 PM ******/
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
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-20T09:30:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, 1, 2, NULL, 1, CAST(1200000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-20T15:45:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-21T10:15:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, 1, 2, NULL, 2, CAST(1200000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-21T18:20:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (7, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-22T08:00:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (8, 1, 2, NULL, 3, CAST(1200000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-23T14:10:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (9, 1, 2, 1, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-23T19:30:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (10, 1, 2, NULL, 4, CAST(1200000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-24T11:05:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (11, 1, 2, 1, NULL, CAST(800000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-06-25T10:00:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4637196' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (12, 1, 2, NULL, 5, CAST(1100000.00 AS Decimal(12, 2)), N'Banking', CAST(N'2026-06-25T16:50:00.0000000' AS DateTime2), N'Paid', N'System', CAST(N'2026-06-30T10:25:26.4648138' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Invoices] ([InvoiceID], [MemberID], [ProcessBy], [MemberPackageID], [PTRegistrationID], [Amount], [PaymentMethod], [PaymentDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (13, 6, 2, 2, NULL, CAST(300000.00 AS Decimal(12, 2)), N'Cash', CAST(N'2026-07-08T10:49:40.6690687' AS DateTime2), N'Paid', N'StaffUserID: 2', CAST(N'2026-07-08T10:49:36.7745873' AS DateTime2), N'StaffUserID: 2', CAST(N'2026-07-08T10:49:40.6690687' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[Invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[MemberPackages] ON 

INSERT [dbo].[MemberPackages] ([MemberPackageID], [MemberID], [PackageID], [StartDate], [EndDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 1, 1, CAST(N'2026-05-01' AS Date), CAST(N'2026-06-01' AS Date), N'Active', N'System', CAST(N'2026-05-31T18:27:47.4782421' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[MemberPackages] ([MemberPackageID], [MemberID], [PackageID], [StartDate], [EndDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 6, 1, CAST(N'2026-07-08' AS Date), CAST(N'2026-08-08' AS Date), N'Active', N'StaffUserID: 2', CAST(N'2026-07-08T10:49:36.7660909' AS DateTime2), N'StaffUserID: 2', CAST(N'2026-07-08T10:49:40.6811133' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[MemberPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 4, N'Nam', CAST(N'2000-01-01' AS Date), N'Hà Nội', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4538048' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 12, N'Nam', CAST(N'2004-10-22' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-09T10:51:16.1071091' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, 14, N'Nam', CAST(N'2004-10-22' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-12T07:48:15.9443539' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, 15, N'Nam', CAST(N'2004-05-17' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-12T07:50:16.0118158' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, 25, N'Nam', CAST(N'2004-10-22' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-25T10:03:26.5753400' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, 27, N'Nữ', CAST(N'2001-06-14' AS Date), N'Hoàn Kiếm-Hà Nội', N'Pending', N'System', CAST(N'2026-06-30T10:37:39.6844516' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Members] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 

INSERT [dbo].[Notifications] ([NotificationID], [Title], [Content], [CreatedBy], [TargetRole], [CreatedByRole], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [PublishDate], [ExpiryDate], [NotificationImageURL]) VALUES (1, N'Chào mừng đến với GCMS!', N'Hệ thống quản lý phòng tập Gym Center đã đi vào hoạt động. Trải nghiệm ngay nhé.', 1, N'All', N'Admin', CAST(N'2026-05-31T18:27:47.4935847' AS DateTime2), NULL, NULL, 0, CAST(N'2026-07-08T10:32:55.2396850' AS DateTime2), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[PersonalTrainers] ON 

INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (1, 3, N'Thể hình (Bodybuilding), Giảm cân', N'Huấn luyện viên thể hình chuyên nghiệp với 5 năm kinh nghiệm.', N'Inactive', N'System', CAST(N'2026-05-31T18:27:47.4644128' AS DateTime2), NULL, NULL, 0, CAST(N'2021-06-03' AS Date), NULL, NULL, N'Personal Trainer', N'Personal Trainer', NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (2, 5, N'Quản lý cân nặng', N'Chuyên hỗ trợ hội viên giảm cân, kiểm soát mỡ và xây dựng thói quen tập luyện bền vững.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8270224' AS DateTime2), NULL, NULL, 0, CAST(N'2022-06-03' AS Date), NULL, NULL, N'Trần Minh Quân', N'Trần Minh Quân', NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (3, 6, N'Tăng cơ', N'Có kinh nghiệm huấn luyện tăng cơ, cải thiện sức mạnh và xây dựng form tập an toàn.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-22T10:10:24.3833333' AS DateTime2), 0, CAST(N'2024-06-14' AS Date), N'Nguyen_Hoang_Nam_TangCo_cer.png', N'assets/uploads/pt-certificate/Nguyen_Hoang_Nam_TangCo_cer.png', N'Nguyễn Hoàng Nam', N'Nguyễn Hoàng Nam', N'')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (4, 7, N'Cardio', N'Hỗ trợ cải thiện sức bền, tim mạch và xây dựng lịch tập cardio phù hợp thể trạng.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-22T09:42:55.7266667' AS DateTime2), 0, CAST(N'2023-06-03' AS Date), NULL, NULL, N'Lê Anh Khoa', N'Anh Khoa Cardio', N'assets/uploads/pt-avatar/1781854280477_Anh_Khoa_update.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (5, 8, N'Tăng cơ, Yoga', N'Chuyên hướng dẫn yoga, cải thiện độ linh hoạt, giảm căng thẳng và phục hồi cơ thể.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-22T10:09:29.7966667' AS DateTime2), 0, CAST(N'2026-06-03' AS Date), N'', N'', N'Phạm Gia Huy', N'Phạm Gia Huy', N'')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (6, 9, N'Boxing', N'Huấn luyện boxing cơ bản đến nâng cao, cải thiện phản xạ, thể lực và kỹ thuật đấm.', N'Active', N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0, CAST(N'2022-06-03' AS Date), NULL, NULL, N'Vũ Đức Long', N'Vũ Đức Long', N'assets/uploads/pt-avatar/vu_duc_long_boxing.png')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (7, 10, N'Dinh dưỡng', N'Chuyên hỗ trợ học viên xây dựng chế độ dinh dưỡng phù hợp với mục tiêu tập luyện, đặc biệt là tăng cơ, giảm mỡ và duy trì sức khỏe. Tư vấn thực đơn cân bằng calories, dễ áp dụng và theo dõi tiến độ để giúp học viên đạt kết quả tốt hơn. Chúc mọi người tập luyện vui vẻ! d', N'Active', N'Demo Admin', CAST(N'2026-06-06T11:03:10.7033333' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-26T02:30:18.2066667' AS DateTime2), 0, CAST(N'2022-11-07' AS Date), N'', N'', N'Nguyễn Trọng Đức Huy', N'Coach Huy DD', N'assets/uploads/pt-avatar/coach_huy_dd.png')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (8, 11, N'Quản lý cân nặng', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-07T09:38:41.5166667' AS DateTime2), NULL, NULL, 0, CAST(N'2025-06-02' AS Date), NULL, NULL, N'Test1', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (9, 13, N'Yoga', N'Chuyên hướng dẫn Yoga & Linh hoạt, hỗ trợ học viên cải thiện độ dẻo dai, tư thế, thăng bằng và kiểm soát hơi thở. Phù hợp cho người mới bắt đầu hoặc người muốn tập luyện nhẹ nhàng, an toàn và đều đặn.', N'Active', N'Demo Admin', CAST(N'2026-06-09T11:56:50.6200000' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-26T02:35:17.4100000' AS DateTime2), 0, CAST(N'2024-02-15' AS Date), N'Nguyen_Thi_Nga_Yoga_cer', N'assets/uploads/pt-certificate/Nguyen_Thi_Nga_Yoga_cer.png', N'Nguyễn Thị Nga', N'Nga Yoga', N'assets/uploads/pt-avatar/Nguyen_Thi_Nga_Yoga.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (10, 16, N'Quản lý cân nặng', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:14:03.7333333' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-11' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (11, 17, N'Quản lý cân nặng', N'âfafaf', N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:19:51.3066667' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-11' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (12, 18, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:40:41.5600000' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-07' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (13, 19, N'Tăng cơ', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:45:42.0800000' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-07' AS Date), NULL, NULL, N'TestPTduplicate', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (14, 20, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:51:48.5033333' AS DateTime2), NULL, NULL, 0, CAST(N'2026-06-01' AS Date), NULL, NULL, N'TestPTduplicate4', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (15, 21, N'Yoga', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-13T18:57:37.3666667' AS DateTime2), NULL, NULL, 0, CAST(N'2026-03-17' AS Date), NULL, NULL, N'TestPTduplicate5', N'Coach DuplicatePhone', NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (16, 22, N'Phục hồi thể lực', N'Tự tin là 1 PT giỏi trong lĩnh vực phục hồi thể lực! 
Sẽ giúp bạn có giây phút healing sau buổi tập căng thẳng. Chúc các bạn sớm có người yêu', N'Active', N'Demo Admin', CAST(N'2026-06-14T00:01:55.0133333' AS DateTime2), N'coachviet_phtl@gmail.com', CAST(N'2026-06-26T02:31:59.5466667' AS DateTime2), 0, CAST(N'2026-06-20' AS Date), N'Tran_Quoc_Viet.png', N'assets/uploads/pt-certificate/Tran_Quoc_Viet.png', N'Trần Quốc Việt', N'Coach Việt', N'assets/uploads/pt-avatar/Coach_Viet_Update.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (17, 23, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-14T01:12:37.1966667' AS DateTime2), NULL, NULL, 0, CAST(N'2025-07-10' AS Date), NULL, NULL, N'Trần Quốc Việt', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (18, 24, N'Cardio', NULL, N'Inactive', N'Demo Admin', CAST(N'2026-06-14T01:32:29.4566667' AS DateTime2), NULL, NULL, 0, CAST(N'2025-07-10' AS Date), NULL, NULL, N'Trần Quốc Gia', NULL, NULL)
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (19, 26, N'Dinh dưỡng', N'', N'Inactive', N'Demo Staff', CAST(N'2026-06-26T01:07:41.9833333' AS DateTime2), N'staff@gym.com', CAST(N'2026-06-30T10:40:59.3900000' AS DateTime2), 0, CAST(N'2026-06-12' AS Date), N'', N'', N'TestSyncLockedPT', NULL, N'')
SET IDENTITY_INSERT [dbo].[PersonalTrainers] OFF
GO
SET IDENTITY_INSERT [dbo].[PTPackageTypes] ON 

INSERT [dbo].[PTPackageTypes] ([PTPackageTypeID], [PackageName], [Description], [DurationMonths], [NumberOfSessions], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Gói PT Cơ bản 1 Tháng', N'Huấn luyện tiêu chuẩn trong 1 tháng với PT.', 1, 12, N'Active', N'System', CAST(N'2026-05-31T18:27:47.4670592' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTPackageTypes] ([PTPackageTypeID], [PackageName], [Description], [DurationMonths], [NumberOfSessions], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'Gói PT Cao cấp 3 Tháng', N'Huấn luyện cao cấp trong 3 tháng với PT.', 3, 36, N'Active', N'System', CAST(N'2026-05-31T18:27:47.4670592' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[PTPackageTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[PTRegistrations] ON 

INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (1, 1, 1, CAST(N'2026-06-01' AS Date), CAST(N'2026-06-01' AS Date), CAST(N'2026-06-30' AS Date), N'Cancelled', N'Đăng ký lần đầu | Lý do hủy: PT đã bị inactive', N'System', CAST(N'2026-05-31T18:27:47.4802560' AS DateTime2), N'Gym Administrator', CAST(N'2026-06-25T00:14:24.6449208' AS DateTime2), 0, CAST(1200000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-25T00:14:24.6449208' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (2, 1, 1, CAST(N'2026-06-01' AS Date), CAST(N'2026-06-01' AS Date), CAST(N'2026-07-01' AS Date), N'Cancelled', N'Tôi muốn nhanh chóng giảm cân
Tôi muốn thử trước 1 tháng | Lý do hủy: PT đã bị Inactive', N'System', CAST(N'2026-06-01T15:51:29.7900382' AS DateTime2), N'Gym Administrator', CAST(N'2026-06-25T00:14:37.5037305' AS DateTime2), 0, CAST(1200000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-25T00:14:37.5037305' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (3, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Active', N'Tôi muốn giảm cân, hãy xếp lịch tập sớm cho tôi', N'System', CAST(N'2026-06-02T04:38:48.7290377' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (4, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Active', N'Tôi thực sự muốn giảm cân. Bạn bè bảo tôi quá béo, tôi rất tự ti.', N'System', CAST(N'2026-06-02T04:39:23.1548789' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (5, 1, 7, CAST(N'2026-06-10' AS Date), CAST(N'2026-06-10' AS Date), CAST(N'2026-07-09' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-07T09:42:34.2420419' AS DateTime2), NULL, NULL, 0, CAST(1100000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (6, 1, 11, CAST(N'2026-06-15' AS Date), CAST(N'2026-06-15' AS Date), CAST(N'2026-07-14' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-14T00:08:42.3140381' AS DateTime2), NULL, NULL, 0, CAST(1350000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (7, 1, 8, CAST(N'2026-06-26' AS Date), CAST(N'2026-06-26' AS Date), CAST(N'2026-09-25' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-24T15:23:02.6051048' AS DateTime2), NULL, NULL, 0, CAST(2970000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 36)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (8, 5, 4, CAST(N'2026-07-01' AS Date), NULL, NULL, N'Cancelled', N'Khởi đầu tháng mới tôi muốn tập giữ cân nặng của tôi cho tới tháng 12 để đi đi thi boxing mức cân 60kg. | Lý do hủy: PT quá bận', N'Nguyễn Đình Phú', CAST(N'2026-06-25T10:16:40.4264412' AS DateTime2), N'Demo Staff', CAST(N'2026-06-26T02:46:08.4461538' AS DateTime2), 0, CAST(3240000.00 AS Decimal(12, 2)), N'Cancelled', 2, CAST(N'2026-06-26T02:46:08.4461538' AS DateTime2), 36)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (9, 5, 12, CAST(N'2026-07-01' AS Date), CAST(N'2026-07-01' AS Date), CAST(N'2026-09-30' AS Date), N'Cancelled', N'Tôi muốn tập boxing ca sáng
 | Lý do hủy: PT bận vkl', N'Nguyễn Đình Phú', CAST(N'2026-06-25T12:15:14.4783089' AS DateTime2), N'Demo Admin', CAST(N'2026-06-25T12:15:56.9338719' AS DateTime2), 0, CAST(3645000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-25T12:15:56.9338719' AS DateTime2), 36)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (10, 1, 7, CAST(N'2026-06-25' AS Date), CAST(N'2026-06-25' AS Date), CAST(N'2026-07-24' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-25T23:47:33.3218669' AS DateTime2), NULL, NULL, 0, CAST(1100000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (11, 1, 17, CAST(N'2026-06-30' AS Date), CAST(N'2026-06-30' AS Date), CAST(N'2026-07-29' AS Date), N'Cancelled', N'Tôi muốn tập thử yoga! | Lý do hủy: Thành viên đăng ký quá nhiều lớp!', N'Demo Member', CAST(N'2026-06-30T10:34:30.1131562' AS DateTime2), N'Demo Admin', CAST(N'2026-06-30T10:35:13.7616447' AS DateTime2), 0, CAST(1500000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-30T10:35:13.7616447' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (12, 6, 17, CAST(N'2026-06-30' AS Date), CAST(N'2026-06-30' AS Date), CAST(N'2026-07-29' AS Date), N'Active', N'Tôi muốn tập yoga để có dánhg đẹp', N'Trần Hà Linh', CAST(N'2026-06-30T10:42:08.4337287' AS DateTime2), NULL, NULL, 0, CAST(1500000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (13, 6, 5, CAST(N'2026-06-30' AS Date), CAST(N'2026-06-30' AS Date), CAST(N'2026-07-29' AS Date), N'Active', N'', N'Trần Hà Linh', CAST(N'2026-06-30T10:56:53.4668020' AS DateTime2), NULL, NULL, 0, CAST(1400000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (14, 6, 13, CAST(N'2026-07-01' AS Date), CAST(N'2026-07-01' AS Date), CAST(N'2026-07-31' AS Date), N'Active', N'Tôi muốn đầu tư thêm cả vào khoản dinh dưỡng sau các buổi tập nữa', N'Trần Hà Linh', CAST(N'2026-07-01T15:15:46.8719952' AS DateTime2), N'Demo Admin', CAST(N'2026-07-07T22:51:06.6869893' AS DateTime2), 0, CAST(999000.00 AS Decimal(12, 2)), N'Paid', 1, CAST(N'2026-07-07T22:51:06.6869893' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (15, 6, 13, CAST(N'2026-07-07' AS Date), CAST(N'2026-07-07' AS Date), CAST(N'2026-08-06' AS Date), N'Active', N'', N'Trần Hà Linh', CAST(N'2026-07-07T23:12:32.2196714' AS DateTime2), N'Demo Staff', CAST(N'2026-07-07T23:13:05.3611825' AS DateTime2), 0, CAST(999000.00 AS Decimal(12, 2)), N'Paid', 2, CAST(N'2026-07-07T23:13:05.3611825' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (16, 5, 5, CAST(N'2026-07-09' AS Date), CAST(N'2026-07-09' AS Date), CAST(N'2026-08-04' AS Date), N'Active', N'', N'Nguyễn Đình Phú', CAST(N'2026-07-08T00:17:08.1787968' AS DateTime2), N'Demo Admin', CAST(N'2026-07-08T00:19:17.6347677' AS DateTime2), 0, CAST(1400000.00 AS Decimal(12, 2)), N'Paid', 1, CAST(N'2026-07-08T00:19:17.6347677' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (17, 6, 19, CAST(N'2026-07-08' AS Date), CAST(N'2026-07-08' AS Date), CAST(N'2026-08-07' AS Date), N'Active', N'Tôi muốn phục hồi thể lực sau 1 ngày đi làm mệt mỏi
', N'Trần Hà Linh', CAST(N'2026-07-08T10:50:20.7435352' AS DateTime2), N'Demo Staff', CAST(N'2026-07-08T10:51:23.1842751' AS DateTime2), 0, CAST(400000.00 AS Decimal(12, 2)), N'Paid', 2, CAST(N'2026-07-08T10:51:23.1842751' AS DateTime2), 12)
SET IDENTITY_INSERT [dbo].[PTRegistrations] OFF
GO
SET IDENTITY_INSERT [dbo].[PTSchedules] ON 

INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (1, 5, 4, 1, CAST(N'2026-06-29' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3466667' AS DateTime2), NULL, CAST(N'2026-06-30T10:35:30.9200000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (2, 5, 4, 1, CAST(N'2026-07-06' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (3, 5, 4, 1, CAST(N'2026-07-13' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (4, 5, 4, 1, CAST(N'2026-07-20' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (5, 5, 4, 1, CAST(N'2026-07-27' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (6, 5, 4, 1, CAST(N'2026-08-03' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (7, 5, 4, 1, CAST(N'2026-08-10' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (8, 5, 4, 1, CAST(N'2026-08-17' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (9, 5, 4, 1, CAST(N'2026-08-24' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (10, 5, 4, 1, CAST(N'2026-08-31' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (11, 5, 4, 1, CAST(N'2026-09-07' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (12, 5, 4, 1, CAST(N'2026-09-14' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:47:34.3533333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (13, 5, 4, 1, CAST(N'2026-06-30' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, CAST(N'2026-06-30T11:04:05.7900000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (14, 5, 4, 1, CAST(N'2026-07-07' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (15, 5, 4, 1, CAST(N'2026-07-14' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (16, 5, 4, 1, CAST(N'2026-07-21' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (17, 5, 4, 1, CAST(N'2026-07-28' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (18, 5, 4, 1, CAST(N'2026-08-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (19, 5, 4, 1, CAST(N'2026-08-11' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (20, 5, 4, 1, CAST(N'2026-08-18' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (21, 5, 4, 1, CAST(N'2026-08-25' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (22, 5, 4, 1, CAST(N'2026-09-01' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (23, 5, 4, 1, CAST(N'2026-09-08' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (24, 5, 4, 1, CAST(N'2026-09-15' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T20:55:05.3200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (25, 5, 4, 1, CAST(N'2026-07-01' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9166667' AS DateTime2), NULL, CAST(N'2026-07-01T23:52:15.7633333' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (26, 5, 4, 1, CAST(N'2026-07-08' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9166667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (27, 5, 4, 1, CAST(N'2026-07-15' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (28, 5, 4, 1, CAST(N'2026-07-22' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (29, 5, 4, 1, CAST(N'2026-07-29' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (30, 5, 4, 1, CAST(N'2026-08-05' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (31, 5, 4, 1, CAST(N'2026-08-12' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (32, 5, 4, 1, CAST(N'2026-08-19' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (33, 5, 4, 1, CAST(N'2026-08-26' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (34, 5, 4, 1, CAST(N'2026-09-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9233333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (35, 5, 4, 1, CAST(N'2026-09-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9266667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (36, 5, 4, 1, CAST(N'2026-09-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:10:50.9266667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (37, 7, 4, 1, CAST(N'2026-07-02' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5333333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (38, 7, 4, 1, CAST(N'2026-07-03' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5333333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (39, 7, 4, 1, CAST(N'2026-07-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (40, 7, 4, 1, CAST(N'2026-07-09' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Cancelled', N'Pending', 1, N'Test đổi lịch', NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), N'Demo Admin', CAST(N'2026-07-07T11:50:47.2866667' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (41, 7, 4, 1, CAST(N'2026-07-10' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (42, 7, 4, 1, CAST(N'2026-07-11' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (43, 7, 4, 1, CAST(N'2026-07-16' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (44, 7, 4, 1, CAST(N'2026-07-17' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (45, 7, 4, 1, CAST(N'2026-07-18' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (46, 7, 4, 1, CAST(N'2026-07-23' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (47, 7, 4, 1, CAST(N'2026-07-24' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (48, 7, 4, 1, CAST(N'2026-07-25' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (49, 7, 4, 1, CAST(N'2026-07-30' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (50, 7, 4, 1, CAST(N'2026-07-31' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (51, 7, 4, 1, CAST(N'2026-08-01' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (52, 7, 4, 1, CAST(N'2026-08-06' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (53, 7, 4, 1, CAST(N'2026-08-07' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (54, 7, 4, 1, CAST(N'2026-08-08' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (55, 7, 4, 1, CAST(N'2026-08-13' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (56, 7, 4, 1, CAST(N'2026-08-14' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (57, 7, 4, 1, CAST(N'2026-08-15' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (58, 7, 4, 1, CAST(N'2026-08-20' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (59, 7, 4, 1, CAST(N'2026-08-21' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (60, 7, 4, 1, CAST(N'2026-08-22' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (61, 7, 4, 1, CAST(N'2026-08-27' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (62, 7, 4, 1, CAST(N'2026-08-28' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (63, 7, 4, 1, CAST(N'2026-08-29' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (64, 7, 4, 1, CAST(N'2026-09-03' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (65, 7, 4, 1, CAST(N'2026-09-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (66, 7, 4, 1, CAST(N'2026-09-05' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (67, 7, 4, 1, CAST(N'2026-09-10' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (68, 7, 4, 1, CAST(N'2026-09-11' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (69, 7, 4, 1, CAST(N'2026-09-12' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (70, 7, 4, 1, CAST(N'2026-09-17' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (71, 7, 4, 1, CAST(N'2026-09-18' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (72, 7, 4, 1, CAST(N'2026-09-19' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:12:27.5366667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (73, 6, 6, 1, CAST(N'2026-06-30' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Completed', N'Absent', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, CAST(N'2026-07-01T21:02:45.0600000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (74, 6, 6, 1, CAST(N'2026-07-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (75, 6, 6, 1, CAST(N'2026-07-03' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (76, 6, 6, 1, CAST(N'2026-07-07' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (77, 6, 6, 1, CAST(N'2026-07-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (78, 6, 6, 1, CAST(N'2026-07-10' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (79, 6, 6, 1, CAST(N'2026-07-14' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (80, 6, 6, 1, CAST(N'2026-07-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (81, 6, 6, 1, CAST(N'2026-07-17' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (82, 6, 6, 1, CAST(N'2026-07-21' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (83, 6, 6, 1, CAST(N'2026-07-23' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (84, 6, 6, 1, CAST(N'2026-07-24' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T21:19:45.4200000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (85, 3, 2, 1, CAST(N'2026-06-25' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0466667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (86, 3, 2, 1, CAST(N'2026-06-26' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0466667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (87, 3, 2, 1, CAST(N'2026-07-01' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, CAST(N'2026-07-01T23:52:25.8933333' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (88, 3, 2, 1, CAST(N'2026-07-02' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Cancelled', N'Pending', 1, N'Hội viên bận đi chơi với người yêu', NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), N'Demo Admin', CAST(N'2026-07-01T23:55:42.5600000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (89, 3, 2, 1, CAST(N'2026-07-03' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (90, 3, 2, 1, CAST(N'2026-07-08' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (91, 3, 2, 1, CAST(N'2026-07-09' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (92, 3, 2, 1, CAST(N'2026-07-10' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (93, 3, 2, 1, CAST(N'2026-07-15' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (94, 3, 2, 1, CAST(N'2026-07-16' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (95, 3, 2, 1, CAST(N'2026-07-17' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (96, 3, 2, 1, CAST(N'2026-07-22' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (97, 10, 4, 1, CAST(N'2026-06-25' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Completed', N'Attended', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (98, 10, 4, 1, CAST(N'2026-06-26' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (99, 10, 4, 1, CAST(N'2026-06-29' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Completed', N'Attended', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, CAST(N'2026-06-30T10:35:32.1633333' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (100, 10, 4, 1, CAST(N'2026-07-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (101, 10, 4, 1, CAST(N'2026-07-03' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (102, 10, 4, 1, CAST(N'2026-07-06' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (103, 10, 4, 1, CAST(N'2026-07-11' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), N'System (Reschedule)', CAST(N'2026-07-08T13:02:07.9866667' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (104, 10, 4, 1, CAST(N'2026-07-10' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (105, 10, 4, 1, CAST(N'2026-07-13' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (106, 10, 4, 1, CAST(N'2026-07-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (107, 10, 4, 1, CAST(N'2026-07-17' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (108, 10, 4, 1, CAST(N'2026-07-20' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), N'Upcoming', N'Pending', 2, NULL, NULL, CAST(N'2026-06-25T23:48:50.9733333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (109, 12, 9, 6, CAST(N'2026-07-01' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5566667' AS DateTime2), NULL, CAST(N'2026-07-01T23:52:29.4600000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (110, 12, 9, 6, CAST(N'2026-07-03' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5566667' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (111, 12, 9, 6, CAST(N'2026-07-08' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (112, 12, 9, 6, CAST(N'2026-07-11' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), N'System (Reschedule)', CAST(N'2026-07-08T13:21:33.0400000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (113, 12, 9, 6, CAST(N'2026-07-15' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (114, 12, 9, 6, CAST(N'2026-07-17' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (115, 12, 9, 6, CAST(N'2026-07-22' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (116, 12, 9, 6, CAST(N'2026-07-24' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (117, 12, 9, 6, CAST(N'2026-07-29' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (118, 12, 9, 6, CAST(N'2026-07-31' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (119, 12, 9, 6, CAST(N'2026-08-05' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (120, 12, 9, 6, CAST(N'2026-08-07' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:42:57.5633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (121, 13, 3, 6, CAST(N'2026-07-01' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Completed', N'Absent', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, CAST(N'2026-07-01T23:53:16.8900000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (122, 13, 3, 6, CAST(N'2026-07-03' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (123, 13, 3, 6, CAST(N'2026-07-08' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (124, 13, 3, 6, CAST(N'2026-07-10' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (125, 13, 3, 6, CAST(N'2026-07-15' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (126, 13, 3, 6, CAST(N'2026-07-17' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (127, 13, 3, 6, CAST(N'2026-07-22' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (128, 13, 3, 6, CAST(N'2026-07-24' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (129, 13, 3, 6, CAST(N'2026-07-29' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (130, 13, 3, 6, CAST(N'2026-07-31' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (131, 13, 3, 6, CAST(N'2026-08-05' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (132, 13, 3, 6, CAST(N'2026-08-07' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-30T10:58:20.9633333' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
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
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (19, 16, 1, CAST(400000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-07-01T19:34:18.1100000' AS DateTime2), N'System', CAST(N'2026-07-08T10:48:25.4633333' AS DateTime2), 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (20, 16, 2, CAST(1100000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-07-01T19:34:18.1133333' AS DateTime2), N'System', CAST(N'2026-07-08T10:48:25.4633333' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[PTServicePrices] OFF
GO
SET IDENTITY_INSERT [dbo].[RescheduleRequests] ON 

INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (1, 103, 7, 4, CAST(N'2026-07-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), CAST(N'2026-07-11' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Approved', N'Bận đi chơi với người yêu', NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-07-08T10:04:31.3879089' AS DateTime2), CAST(N'2026-07-08T13:02:07.9833640' AS DateTime2))
INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (2, 123, 27, 6, CAST(N'2026-07-08' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), CAST(N'2026-07-09' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Escalated', N'Bận tập yoga cùng ca', NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-07-08T11:53:47.3574511' AS DateTime2), CAST(N'2026-07-08T13:03:58.1279396' AS DateTime2))
INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (3, 124, 6, 27, CAST(N'2026-07-10' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), CAST(N'2026-07-09' AS Date), CAST(N'15:15:00' AS Time), CAST(N'16:45:00' AS Time), N'Rejected', N'Nam đang ốm', NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-07-08T13:16:02.9716566' AS DateTime2), CAST(N'2026-07-08T13:16:31.9243121' AS DateTime2))
INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (4, 112, 27, 13, CAST(N'2026-07-10' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), CAST(N'2026-07-11' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Approved', N'Em bận chăm con', NULL, 13, CAST(N'2026-07-08T13:21:33.0399056' AS DateTime2), NULL, NULL, NULL, CAST(N'2026-07-08T13:20:49.6322291' AS DateTime2), CAST(N'2026-07-08T13:21:33.0399056' AS DateTime2))
INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (5, 113, 13, 27, CAST(N'2026-07-15' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), CAST(N'2026-07-09' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Escalated', N'Test bận', NULL, NULL, NULL, 27, CAST(N'2026-07-08T14:21:50.2455149' AS DateTime2), N'', CAST(N'2026-07-08T14:19:45.1823424' AS DateTime2), CAST(N'2026-07-08T14:21:50.2455149' AS DateTime2))
INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (6, 111, 13, 27, CAST(N'2026-07-08' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), CAST(N'2026-07-09' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Escalated', N'abccccc', NULL, NULL, NULL, 27, CAST(N'2026-07-08T14:28:48.3342777' AS DateTime2), N'Test khiếu nại admin', CAST(N'2026-07-08T14:26:39.7892428' AS DateTime2), CAST(N'2026-07-08T14:28:48.3342777' AS DateTime2))
SET IDENTITY_INSERT [dbo].[RescheduleRequests] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Admin', 1, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'Staff', 2, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, N'PT', 3, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleLevel], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, N'Member', 4, N'System', CAST(N'2026-05-31T18:27:47.4352869' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[StaffPTAttendance] ON 

INSERT [dbo].[StaffPTAttendance] ([AttendanceID], [UserID], [UserRole], [CheckedInAt], [CheckedOutAt], [ShiftBlock], [Status], [CheckedBy], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 10, N'PT', CAST(N'2026-06-30T10:27:11.1224086' AS DateTime2), CAST(N'2026-06-30T10:27:30.2049946' AS DateTime2), N'Morning', N'Active', 2, NULL, N'Demo Staff', CAST(N'2026-06-30T10:27:11.1224086' AS DateTime2), N'2', CAST(N'2026-06-30T10:27:30.2049946' AS DateTime2), 0)
INSERT [dbo].[StaffPTAttendance] ([AttendanceID], [UserID], [UserRole], [CheckedInAt], [CheckedOutAt], [ShiftBlock], [Status], [CheckedBy], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 11, N'PT', CAST(N'2026-06-30T10:27:16.0472539' AS DateTime2), NULL, N'Morning', N'Active', 2, NULL, N'Demo Staff', CAST(N'2026-06-30T10:27:16.0472539' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[StaffPTAttendance] OFF
GO
SET IDENTITY_INSERT [dbo].[Staffs] ON 

INSERT [dbo].[Staffs] ([StaffID], [UserID], [Position], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 2, N'Receptionist', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4559441' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Staffs] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Tokens] ON 

INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (1, 12, N'6f848a95-403e-4aa6-8aa3-f001f2f515fe', N'VERIFICATION', CAST(N'2026-06-09T10:51:16.1112407' AS DateTime2), CAST(N'2026-06-10T10:51:16.0763519' AS DateTime2), 0)
INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (2, 14, N'79e1b34a-e8a2-4f95-b4c8-50797f949e32', N'VERIFICATION', CAST(N'2026-06-12T07:48:15.9478538' AS DateTime2), CAST(N'2026-06-13T07:48:15.9080088' AS DateTime2), 0)
INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (3, 15, N'f275d1de-f0e1-4732-9d6c-fbbd3ea307d7', N'VERIFICATION', CAST(N'2026-06-12T07:50:16.0128766' AS DateTime2), CAST(N'2026-06-13T07:50:15.9967988' AS DateTime2), 0)
INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (7, 25, N'41f17404-fd24-4e6d-a555-19d54975c17d', N'VERIFICATION', CAST(N'2026-06-25T10:03:26.5807895' AS DateTime2), CAST(N'2026-06-26T10:03:26.5497413' AS DateTime2), 0)
INSERT [dbo].[User_Tokens] ([TokenID], [UserID], [TokenValue], [TokenType], [CreatedAt], [ExpiresAt], [IsUsed]) VALUES (8, 27, N'0ada745f-ea4c-42bf-becd-a52372ed0cb8', N'VERIFICATION', CAST(N'2026-06-30T10:37:39.6915947' AS DateTime2), CAST(N'2026-07-01T10:37:39.6767761' AS DateTime2), 0)
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
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (13, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (16, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (17, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (18, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (19, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (20, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (21, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (22, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (23, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (24, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (26, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (4, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (12, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (14, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (15, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (25, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (27, 4)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'admin@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Gym Administrator', N'0912345678', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'staff@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Staff Member', N'0912345679', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (3, N'pt@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Personal Trainer', N'0912345680', N'Active', 1, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (4, N'member@gym.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Gym Member', N'0912345681', N'Active', 0, N'System', CAST(N'2026-05-31T18:27:47.4447986' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, N'pt.quan@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Trần Minh Quân', N'0901000001', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8255136' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, N'pt.nam@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Nguyễn Hoàng Nam', N'0901000002', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, CAST(N'2026-07-08T00:23:37.2157221' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (7, N'pt.khoa@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Lê Anh Khoa', N'0901000006', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8290745' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (8, N'pt.huy@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Phạm Gia Huy', N'0901000004', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (9, N'pt.long@gcms.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Vũ Đức Long', N'0901000005', N'Active', 0, N'System', CAST(N'2026-06-02T03:59:40.8300775' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (10, N'huydd@gmail.com', N'a64a02b0ecc1767cd2b932134c7fb00cb6b47bbec32979b99bb64513b54f4195', N'Coach Huy DD', N'0999999999', N'Active', 0, N'Demo Admin', CAST(N'2026-06-06T11:03:10.6620000' AS DateTime2), NULL, CAST(N'2026-06-26T02:30:18.2100000' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (11, N'testpt@gmail.con', N'c1ee98257c924b0e2aae86e715ae4b6fe8b96739a6387b8075e2903e74816042', N'Test1', N'0000000000', N'Active', 0, N'Demo Admin', CAST(N'2026-06-07T09:38:41.4730000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (12, N'phuhocfpt@gmail.com', N'b0f5f5bd0a78188853fde457b835ab7466b15f66667991ef61d72d45d34fd649', N'Nguyễn Đình Phú', N'0559442269', N'Inactive', 0, N'System', CAST(N'2026-06-09T10:51:16.0903641' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (13, N'ngayogapt@gmai.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Nga Yoga', N'0987986435', N'Active', 0, N'Demo Admin', CAST(N'2026-06-09T11:56:50.5990000' AS DateTime2), NULL, CAST(N'2026-06-30T10:54:13.6800167' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (14, N'nhasi1110@gmail.com', N'b0f5f5bd0a78188853fde457b835ab7466b15f66667991ef61d72d45d34fd649', N'Nguyễn Đình Phú', N'0559442269', N'Inactive', 0, N'System', CAST(N'2026-06-12T07:48:15.9281849' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (15, N'nguyentrilinh2004@gmail.com', N'efd191441e48fc51e7cd7ee3b5621ecde769240e9438e980c84e46a895181444', N'Nguyễn Trí Linh', N'0123659843', N'Inactive', 0, N'System', CAST(N'2026-06-12T07:50:16.0096844' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (16, N'testpt@gmail.com', N'eb146dabbe1ae89ec3a7957cd6cec902a803f42b9d161118fb0e0068f849de7f', N'TestPTduplicate', N'0000000000', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:14:03.7020000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (17, N'come@gmail.com', N'37b41a5d4a5105e6e9427e951811dc77ea736c470c93f07b2c747656a03b87a8', N'TestPTduplicate', N'0000000000', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:19:51.2970000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (18, N'testduplicatephone@gmail.com', N'354266efb4713f6fedd096f550fce5ee1048f696178cd97706b23368a827c723', N'TestPTduplicate', N'0999999999', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:40:41.5460000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (19, N'testduplicatephone_1@gmail.com', N'f4f1dace5e29364f34eff5ba6ff83bd09808d0a88c6fcc1fc9817364eda27502', N'TestPTduplicate', N'0912345680', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:45:42.0730000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (20, N'testduplicatephone_4@gmail.com', N'c50f235901398bba3aea4b8f65a3986335a518f97ca407ac3be24aa8cf8e1281', N'TestPTduplicate4', N'0901000001', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:51:48.4900000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (21, N'testduplicatephone_5@gmail.com', N'8ca0506fac88d10138d61174083b0e34b6e400cfa959bd5da456a05437ac92f1', N'Coach DuplicatePhone', N'0901000001', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-13T18:57:37.3580000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (22, N'coachviet_phtl@gmail.com', N'00650ae6b819d1af2d2db529cb693428f4e2175bb746b143718d15d29495ae9c', N'Trần Quốc Việt', N'0124579641', N'Active', 0, N'Demo Admin', CAST(N'2026-06-14T00:01:54.9910000' AS DateTime2), NULL, CAST(N'2026-06-18T17:58:16.0548873' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (23, N'coachviet_phtldd@gmail.conme', N'278904f8cfcb27a835a51a1b5a81572448a3adaa53e3d7740afb5f3c160b33cd', N'Trần Quốc Việt', N'0124579632', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-14T01:12:37.1640000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (24, N'coachviet_phtldd@gmail.conmecsff', N'5773b0f3afcc874b1d9eae06e933e01ad0674afd104c22a05c19d9b3c04a8dab', N'Trần Quốc Gia', N'0124579632', N'Inactive', 1, N'Demo Admin', CAST(N'2026-06-14T01:32:29.4460000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (25, N'phundhe181315@fpt.edu.vn', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Nguyễn Đình Phú', N'0102030908', N'Active', 0, N'System', CAST(N'2026-06-25T10:03:26.5569284' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (26, N'lockedptsync@lockedptsync.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'TestSyncLockedPT', N'0147852236', N'Locked', 0, N'Demo Staff', CAST(N'2026-06-26T01:07:41.9663468' AS DateTime2), N'staff@gym.com', CAST(N'2026-06-30T10:40:59.3958107' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (27, N'member.halinh@gmail.com', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Trần Hà Linh', N'0354123965', N'Active', 0, N'System', CAST(N'2026-06-30T10:37:39.6801440' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_EquipmentIssues_Equipment_Status]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_EquipmentIssues_Equipment_Status] ON [dbo].[EquipmentIssues]
(
	[EquipmentID] ASC
)
INCLUDE([Status],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Equipments_Code]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[Equipments] ADD  CONSTRAINT [UQ_Equipments_Code] UNIQUE NONCLUSTERED 
(
	[EquipmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Invoices_ForeignKeys]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_Invoices_ForeignKeys] ON [dbo].[Invoices]
(
	[MemberID] ASC
)
INCLUDE([MemberPackageID],[PTRegistrationID],[Status],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_MaintenanceSchedules_Search]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_MaintenanceSchedules_Search] ON [dbo].[MaintenanceSchedules]
(
	[Status] ASC,
	[ScheduledDate] DESC,
	[EquipmentID] ASC
)
INCLUDE([MaintenanceType],[IssueID],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_MaintenanceSchedules_Equipment_Date_Active]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_MaintenanceSchedules_Equipment_Date_Active] ON [dbo].[MaintenanceSchedules]
(
	[EquipmentID] ASC,
	[ScheduledDate] ASC
)
WHERE ([IsDeleted]=(0) AND [Status]<>'Cancelled')
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MemberPackages_Member_Package]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_MemberPackages_Member_Package] ON [dbo].[MemberPackages]
(
	[MemberID] ASC,
	[PackageID] ASC
)
INCLUDE([StartDate],[EndDate],[Status],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Members_UserID]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[Members] ADD  CONSTRAINT [UQ_Members_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Members_Status_Deleted]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_Members_Status_Deleted] ON [dbo].[Members]
(
	[MembershipStatus] ASC,
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_NotificationRecipients_Notification_User]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[NotificationRecipients] ADD  CONSTRAINT [UQ_NotificationRecipients_Notification_User] UNIQUE NONCLUSTERED 
(
	[NotificationID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PT_UserID]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[PersonalTrainers] ADD  CONSTRAINT [UQ_PT_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PersonalTrainers_Status_Deleted]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_PersonalTrainers_Status_Deleted] ON [dbo].[PersonalTrainers]
(
	[Status] ASC,
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PTRegistrations_Member_Price]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_PTRegistrations_Member_Price] ON [dbo].[PTRegistrations]
(
	[MemberID] ASC,
	[PTServicePriceID] ASC
)
INCLUDE([Status],[PaymentStatus],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PTRegistrations_Pending_Duplicate]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_PTRegistrations_Pending_Duplicate] ON [dbo].[PTRegistrations]
(
	[MemberID] ASC,
	[PTServicePriceID] ASC
)
WHERE ([Status]='Pending' AND [IsDeleted]=(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PTSchedules_Slot]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[PTSchedules] ADD  CONSTRAINT [UQ_PTSchedules_Slot] UNIQUE NONCLUSTERED 
(
	[PTID] ASC,
	[SessionDate] ASC,
	[StartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PTSchedules_Member_Date_Time]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_PTSchedules_Member_Date_Time] ON [dbo].[PTSchedules]
(
	[MemberID] ASC,
	[SessionDate] ASC,
	[StartTime] ASC,
	[EndTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PTSchedules_Member_Reg]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_PTSchedules_Member_Reg] ON [dbo].[PTSchedules]
(
	[MemberID] ASC,
	[PTRegistrationID] ASC
)
INCLUDE([SessionStatus],[PTAttendanceResult],[IsDeleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PTSchedules_PT_Date_Time]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_PTSchedules_PT_Date_Time] ON [dbo].[PTSchedules]
(
	[PTID] ASC,
	[SessionDate] ASC,
	[StartTime] ASC,
	[EndTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PTServicePrices_PT_Package]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[PTServicePrices] ADD  CONSTRAINT [UQ_PTServicePrices_PT_Package] UNIQUE NONCLUSTERED 
(
	[PTID] ASC,
	[PTPackageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PTServicePrices_Status_Deleted]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_PTServicePrices_Status_Deleted] ON [dbo].[PTServicePrices]
(
	[Status] ASC,
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RescheduleRequests_Receiver_Status]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_RescheduleRequests_Receiver_Status] ON [dbo].[RescheduleRequests]
(
	[ReceiverUserID] ASC,
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RescheduleRequests_Schedule]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_RescheduleRequests_Schedule] ON [dbo].[RescheduleRequests]
(
	[PTScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RescheduleRequests_Sender]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_RescheduleRequests_Sender] ON [dbo].[RescheduleRequests]
(
	[SenderUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Roles_Name]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [UQ_Roles_Name] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Staffs_UserID]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[Staffs] ADD  CONSTRAINT [UQ_Staffs_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User_Tok__FE1B80EC9EED5FA6]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[User_Tokens] ADD UNIQUE NONCLUSTERED 
(
	[TokenValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRoles_RoleID]    Script Date: 7/8/2026 2:38:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleID] ON [dbo].[UserRoles]
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 7/8/2026 2:38:42 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_Status_Deleted]    Script Date: 7/8/2026 2:38:42 PM ******/
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
ALTER TABLE [dbo].[MaintenanceSchedules] ADD  CONSTRAINT [DF_MaintenanceSchedules_Status]  DEFAULT ('Scheduled') FOR [Status]
GO
ALTER TABLE [dbo].[MaintenanceSchedules] ADD  CONSTRAINT [DF_MaintenanceSchedules_CreatedDate]  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[MaintenanceSchedules] ADD  CONSTRAINT [DF_MaintenanceSchedules_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MaintenanceSchedules] ADD  CONSTRAINT [DF_MaintenanceSchedules_RequestedIssueResolution]  DEFAULT ((0)) FOR [RequestedIssueResolution]
GO
ALTER TABLE [dbo].[MemberPackages] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[MemberPackages] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Members] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Members] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[NotificationRecipients] ADD  CONSTRAINT [DF_NotificationRecipients_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[NotificationRecipients] ADD  CONSTRAINT [DF_NotificationRecipients_CreatedDate]  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (sysdatetime()) FOR [PublishDate]
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
ALTER TABLE [dbo].[RescheduleRequests] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[RescheduleRequests] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[StaffPTAttendance] ADD  CONSTRAINT [DF_StaffPTAttendance_CheckedInAt]  DEFAULT (sysdatetime()) FOR [CheckedInAt]
GO
ALTER TABLE [dbo].[StaffPTAttendance] ADD  CONSTRAINT [DF_StaffPTAttendance_Status]  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[StaffPTAttendance] ADD  CONSTRAINT [DF_StaffPTAttendance_CreatedDate]  DEFAULT (sysdatetime()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[StaffPTAttendance] ADD  CONSTRAINT [DF_StaffPTAttendance_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
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
ALTER TABLE [dbo].[MaintenanceSchedules]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceSchedules_EquipmentIssues] FOREIGN KEY([IssueID])
REFERENCES [dbo].[EquipmentIssues] ([IssueID])
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [FK_MaintenanceSchedules_EquipmentIssues]
GO
ALTER TABLE [dbo].[MaintenanceSchedules]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceSchedules_Equipments] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipments] ([EquipmentID])
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [FK_MaintenanceSchedules_Equipments]
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
ALTER TABLE [dbo].[NotificationRecipients]  WITH CHECK ADD  CONSTRAINT [FK_NotificationRecipients_Notifications] FOREIGN KEY([NotificationID])
REFERENCES [dbo].[Notifications] ([NotificationID])
GO
ALTER TABLE [dbo].[NotificationRecipients] CHECK CONSTRAINT [FK_NotificationRecipients_Notifications]
GO
ALTER TABLE [dbo].[NotificationRecipients]  WITH CHECK ADD  CONSTRAINT [FK_NotificationRecipients_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[NotificationRecipients] CHECK CONSTRAINT [FK_NotificationRecipients_Users]
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
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PTSchedules_CancelledBy] FOREIGN KEY([CancelledByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [FK_PTSchedules_CancelledBy]
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
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PTSchedules_OriginalPT] FOREIGN KEY([OriginalPTID])
REFERENCES [dbo].[PersonalTrainers] ([PTID])
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [FK_PTSchedules_OriginalPT]
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
ALTER TABLE [dbo].[PTSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PTSchedules_SubstituteBy] FOREIGN KEY([SubstituteByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PTSchedules] CHECK CONSTRAINT [FK_PTSchedules_SubstituteBy]
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
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_EscalatedBy] FOREIGN KEY([EscalatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_EscalatedBy]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_PTSchedules] FOREIGN KEY([PTScheduleID])
REFERENCES [dbo].[PTSchedules] ([PTScheduleID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_PTSchedules]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_Receiver] FOREIGN KEY([ReceiverUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_Receiver]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_RespondedBy] FOREIGN KEY([RespondedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_RespondedBy]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_Sender] FOREIGN KEY([SenderUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_Sender]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [FK_StaffPTAttendance_CheckedBy] FOREIGN KEY([CheckedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [FK_StaffPTAttendance_CheckedBy]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [FK_StaffPTAttendance_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [FK_StaffPTAttendance_Users]
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
ALTER TABLE [dbo].[MaintenanceSchedules]  WITH CHECK ADD  CONSTRAINT [CK_MaintenanceSchedules_Status] CHECK  (([Status]='Scheduled' OR [Status]='InProgress' OR [Status]='PendingApproval' OR [Status]='Completed' OR [Status]='Cancelled'))
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [CK_MaintenanceSchedules_Status]
GO
ALTER TABLE [dbo].[MaintenanceSchedules]  WITH CHECK ADD  CONSTRAINT [CK_MaintenanceSchedules_Type] CHECK  (([MaintenanceType]='Preventive' OR [MaintenanceType]='Corrective'))
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [CK_MaintenanceSchedules_Type]
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
ALTER TABLE [dbo].[PTPackageTypes]  WITH CHECK ADD  CONSTRAINT [CK_PTPackageTypes_NumberOfSessions] CHECK  (([NumberOfSessions]>(0)))
GO
ALTER TABLE [dbo].[PTPackageTypes] CHECK CONSTRAINT [CK_PTPackageTypes_NumberOfSessions]
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
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [CK_PTRegistrations_PurchasedSessions] CHECK  (([PurchasedSessions]>(0)))
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [CK_PTRegistrations_PurchasedSessions]
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
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [CK_RescheduleRequests_Status] CHECK  (([Status]='Escalated' OR [Status]='Rejected' OR [Status]='Approved' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [CK_RescheduleRequests_Status]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [CK_RescheduleRequests_Time] CHECK  (([ProposedStartTime]<[ProposedEndTime]))
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [CK_RescheduleRequests_Time]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Role] CHECK  (([UserRole]='PT' OR [UserRole]='Staff'))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Role]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Shift] CHECK  (([ShiftBlock]='Evening' OR [ShiftBlock]='Afternoon' OR [ShiftBlock]='Morning'))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Shift]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Status] CHECK  (([Status]='Cancelled' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Status]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Time] CHECK  (([CheckedOutAt] IS NULL OR [CheckedOutAt]>=[CheckedInAt]))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Time]
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
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_EscalatedBy] FOREIGN KEY([EscalatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_EscalatedBy]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_PTSchedules] FOREIGN KEY([PTScheduleID])
REFERENCES [dbo].[PTSchedules] ([PTScheduleID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_PTSchedules]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_Receiver] FOREIGN KEY([ReceiverUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_Receiver]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_RespondedBy] FOREIGN KEY([RespondedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_RespondedBy]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [FK_RescheduleRequests_Sender] FOREIGN KEY([SenderUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [FK_RescheduleRequests_Sender]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [FK_StaffPTAttendance_CheckedBy] FOREIGN KEY([CheckedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [FK_StaffPTAttendance_CheckedBy]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [FK_StaffPTAttendance_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [FK_StaffPTAttendance_Users]
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
ALTER TABLE [dbo].[MaintenanceSchedules]  WITH CHECK ADD  CONSTRAINT [CK_MaintenanceSchedules_Status] CHECK  (([Status]='Scheduled' OR [Status]='InProgress' OR [Status]='PendingApproval' OR [Status]='Completed' OR [Status]='Cancelled'))
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [CK_MaintenanceSchedules_Status]
GO
ALTER TABLE [dbo].[MaintenanceSchedules]  WITH CHECK ADD  CONSTRAINT [CK_MaintenanceSchedules_Type] CHECK  (([MaintenanceType]='Preventive' OR [MaintenanceType]='Corrective'))
GO
ALTER TABLE [dbo].[MaintenanceSchedules] CHECK CONSTRAINT [CK_MaintenanceSchedules_Type]
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
ALTER TABLE [dbo].[PTPackageTypes]  WITH CHECK ADD  CONSTRAINT [CK_PTPackageTypes_NumberOfSessions] CHECK  (([NumberOfSessions]>(0)))
GO
ALTER TABLE [dbo].[PTPackageTypes] CHECK CONSTRAINT [CK_PTPackageTypes_NumberOfSessions]
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
ALTER TABLE [dbo].[PTRegistrations]  WITH CHECK ADD  CONSTRAINT [CK_PTRegistrations_PurchasedSessions] CHECK  (([PurchasedSessions]>(0)))
GO
ALTER TABLE [dbo].[PTRegistrations] CHECK CONSTRAINT [CK_PTRegistrations_PurchasedSessions]
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
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [CK_RescheduleRequests_Status] CHECK  (([Status]='Escalated' OR [Status]='Rejected' OR [Status]='Approved' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [CK_RescheduleRequests_Status]
GO
ALTER TABLE [dbo].[RescheduleRequests]  WITH CHECK ADD  CONSTRAINT [CK_RescheduleRequests_Time] CHECK  (([ProposedStartTime]<[ProposedEndTime]))
GO
ALTER TABLE [dbo].[RescheduleRequests] CHECK CONSTRAINT [CK_RescheduleRequests_Time]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Role] CHECK  (([UserRole]='PT' OR [UserRole]='Staff'))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Role]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Shift] CHECK  (([ShiftBlock]='Evening' OR [ShiftBlock]='Afternoon' OR [ShiftBlock]='Morning'))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Shift]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Status] CHECK  (([Status]='Cancelled' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Status]
GO
ALTER TABLE [dbo].[StaffPTAttendance]  WITH CHECK ADD  CONSTRAINT [CK_StaffPTAttendance_Time] CHECK  (([CheckedOutAt] IS NULL OR [CheckedOutAt]>=[CheckedInAt]))
GO
ALTER TABLE [dbo].[StaffPTAttendance] CHECK CONSTRAINT [CK_StaffPTAttendance_Time]
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

/****** Object:  Table [dbo].[PublicContents]    Script Date: 7/17/2026 12:20:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
USE [GymCenterManagement]
GO
CREATE TABLE [dbo].[PublicContents](
	[ContentID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Summary] [nvarchar](500) NULL,
	[Body] [nvarchar](max) NOT NULL,
	[ContentType] [varchar](20) NOT NULL,
	[Category] [nvarchar](100) NULL,
	[ThumbnailURL] [nvarchar](255) NULL,
	[Status] [varchar](20) NOT NULL,
	[PublishedAt] [datetime2](7) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PublicContents] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[PublicContents] ON 

INSERT [dbo].[PublicContents] ([ContentID], [Title], [Summary], [Body], [ContentType], [Category], [ThumbnailURL], [Status], [PublishedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsDeleted]) VALUES (1, N'Chuẩn bị trước buổi tập đầu tiên', N'Những việc hội viên nên chuẩn bị trước khi bắt đầu lịch tập tại phòng gym.', N'Hãy đến sớm khoảng 10 phút để hoàn tất kiểm tra thông tin, chuẩn bị nước uống, khăn tập và trang phục thoải mái. Nếu có vấn đề sức khỏe đặc biệt, hãy trao đổi với nhân viên hoặc PT trước khi tập để được hướng dẫn phù hợp.', N'BLOG', N'Kinh nghiệm tập luyện', NULL, N'Published', CAST(N'2026-07-17T00:20:00' AS DateTime2), N'System', CAST(N'2026-07-17T00:20:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PublicContents] ([ContentID], [Title], [Summary], [Body], [ContentType], [Category], [ThumbnailURL], [Status], [PublishedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsDeleted]) VALUES (2, N'Uống đủ nước khi luyện tập', N'Lưu ý đơn giản giúp cơ thể duy trì hiệu suất và phục hồi tốt hơn.', N'Nước hỗ trợ điều hòa nhiệt độ, vận chuyển dinh dưỡng và giảm cảm giác mệt mỏi trong quá trình tập. Hội viên nên uống từng ngụm nhỏ trước, trong và sau buổi tập; tránh chờ đến khi quá khát mới bổ sung nước.', N'BLOG', N'Phục hồi', NULL, N'Published', CAST(N'2026-07-17T00:20:00' AS DateTime2), N'System', CAST(N'2026-07-17T00:20:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PublicContents] ([ContentID], [Title], [Summary], [Body], [ContentType], [Category], [ThumbnailURL], [Status], [PublishedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsDeleted]) VALUES (3, N'Chính sách bảo lưu gói tập', N'Quy định chung về bảo lưu thời hạn sử dụng gói tập.', N'Hội viên có thể liên hệ quầy lễ tân để gửi yêu cầu bảo lưu khi có lý do phù hợp. Thời gian, điều kiện và giấy tờ hỗ trợ sẽ được nhân viên kiểm tra theo từng loại gói và trạng thái thanh toán hiện tại.', N'POLICY', N'Bảo lưu', NULL, N'Published', CAST(N'2026-07-17T00:20:00' AS DateTime2), N'System', CAST(N'2026-07-17T00:20:00' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[PublicContents] OFF
GO

SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PublicContents_Management]    Script Date: 7/17/2026 12:20:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_PublicContents_Management] ON [dbo].[PublicContents]
(
	[IsDeleted] ASC,
	[ContentType] ASC,
	[Status] ASC,
	[ContentID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PublicContents_Public]    Script Date: 7/17/2026 12:20:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_PublicContents_Public] ON [dbo].[PublicContents]
(
	[ContentType] ASC,
	[Status] ASC,
	[IsDeleted] ASC,
	[PublishedAt] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PublicContents] ADD  DEFAULT ('Draft') FOR [Status]
GO
ALTER TABLE [dbo].[PublicContents] ADD  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[PublicContents] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PublicContents]  WITH CHECK ADD  CONSTRAINT [CK_PublicContents_ContentType] CHECK  (([ContentType]='POLICY' OR [ContentType]='BLOG'))
GO
ALTER TABLE [dbo].[PublicContents] CHECK CONSTRAINT [CK_PublicContents_ContentType]
GO
ALTER TABLE [dbo].[PublicContents]  WITH CHECK ADD  CONSTRAINT [CK_PublicContents_Status] CHECK  (([Status]='Hidden' OR [Status]='Published' OR [Status]='Draft'))
GO
ALTER TABLE [dbo].[PublicContents] CHECK CONSTRAINT [CK_PublicContents_Status]
GO

USE [GymCenterManagement]

GO

IF OBJECT_ID(N'dbo.FAQ', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.FAQ (
        faq_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        question NVARCHAR(500) NOT NULL,
        answer NVARCHAR(MAX) NOT NULL,
        category NVARCHAR(100) NULL,
        keywords NVARCHAR(1000) NULL,
        status NVARCHAR(20) NOT NULL CONSTRAINT DF_FAQ_Status DEFAULT N'Active',
        created_at DATETIME2 NOT NULL CONSTRAINT DF_FAQ_CreatedAt DEFAULT SYSDATETIME(),
        updated_at DATETIME2 NULL
    );

    CREATE INDEX IX_FAQ_Status ON dbo.FAQ(status);
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xin chào')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xin chào',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chào')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chào',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chào bạn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chào bạn',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hello')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hello',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hey')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hey',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Alo')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Alo',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ai không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ai không?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chatbot ơi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chatbot ơi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bot ơi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bot ơi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Trợ lý ơi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Trợ lý ơi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn là ai?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn làm được gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn làm được gì?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn hỗ trợ được gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn hỗ trợ được gì?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi cần tư vấn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi cần tư vấn',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có người hỗ trợ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có người hỗ trợ không?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn hỏi thông tin phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn hỏi thông tin phòng gym',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn có thể giúp tôi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn có thể giúp tôi không?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cho tôi hỏi chút')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cho tôi hỏi chút',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mình cần hỏi về phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mình cần hỏi về phòng gym',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao để đăng ký hội viên?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao để đăng ký hội viên?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký hội viên như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký hội viên như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Muốn đăng ký tập gym thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Muốn đăng ký tập gym thì làm sao?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tham gia phòng gym thì làm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tham gia phòng gym thì làm gì?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký trực tiếp được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký trực tiếp được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có đăng ký tại quầy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có đăng ký tại quầy không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có đăng ký qua website không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có đăng ký qua website không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có đăng ký online không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có đăng ký online không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có thể tạo tài khoản hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có thể tạo tài khoản hội viên ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mở tài khoản hội viên như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mở tài khoản hội viên như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạo tài khoản mới thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạo tài khoản mới thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi chưa có tài khoản thì đăng ký ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi chưa có tài khoản thì đăng ký ra sao?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký cần thông tin gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký cần thông tin gì?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký cần chuẩn bị gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký cần chuẩn bị gì?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cần những giấy tờ gì để đăng ký?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cần những giấy tờ gì để đăng ký?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cần CCCD không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cần CCCD không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần căn cước công dân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần căn cước công dân không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần số điện thoại khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần số điện thoại khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần email khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần email khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Email đã dùng rồi có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Email đã dùng rồi có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số điện thoại đã dùng rồi có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số điện thoại đã dùng rồi có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao nhiêu tuổi được đăng ký?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao nhiêu tuổi được đăng ký?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Học sinh có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Học sinh có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sinh viên có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sinh viên có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người dưới 18 tuổi có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người dưới 18 tuổi có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao lâu thì đăng ký xong?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao lâu thì đăng ký xong?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký mất bao lâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký mất bao lâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký xong có tập ngay được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký xong có tập ngay được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khi nào tài khoản được kích hoạt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khi nào tài khoản được kích hoạt?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mua gói ngay khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mua gói ngay khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký tài khoản có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký tài khoản có mất phí không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạo tài khoản có cần thanh toán không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạo tài khoản có cần thanh toán không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần tài khoản để mua gói không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần tài khoản để mua gói không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có thể nhờ lễ tân đăng ký giúp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có thể nhờ lễ tân đăng ký giúp không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người mới đến lần đầu đăng ký thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người mới đến lần đầu đăng ký thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đăng ký trước rồi thanh toán sau không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đăng ký trước rồi thanh toán sau không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký hội viên mới có được tư vấn gói tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký hội viên mới có được tư vấn gói tập không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn mở thẻ hội viên')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn mở thẻ hội viên',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm thẻ hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm thẻ hội viên ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký member như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký member như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Join gym như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Join gym như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Membership registration ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Membership registration ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần xác thực email khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần xác thực email khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký xong có nhận thông báo không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký xong có nhận thông báo không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có những gói tập nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có những gói tập nào?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có gói tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có gói tập gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Danh sách gói tập hiện có?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Danh sách gói tập hiện có?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bao nhiêu gói gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bao nhiêu gói gym?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Các loại gói hội viên là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Các loại gói hội viên là gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Membership package gồm những gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Membership package gồm những gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Package hiện có là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Package hiện có là gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cơ bản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cơ bản không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cao cấp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cao cấp không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói 1 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói 1 tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói 3 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói 3 tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói ngắn hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói ngắn hạn không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói dài hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói dài hạn không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói năm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói năm không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói 6 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói 6 tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói theo ngày không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói theo ngày không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tập thử không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tập thử không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cho người mới không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cho người mới không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cho sinh viên không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cho sinh viên không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói gia đình không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói gia đình không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cặp đôi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cặp đôi không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tập buổi sáng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tập buổi sáng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tập buổi tối không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tập buổi tối không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cuối tuần không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cuối tuần không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói không giới hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói không giới hạn không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá gói tập bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá gói tập bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá gói gym là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá gói gym là bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao nhiêu tiền một gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao nhiêu tiền một gói tập?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chi phí tập gym là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chi phí tập gym là bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảng giá gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảng giá gói tập?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Price gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Price gói tập?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cost membership?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cost membership?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tập giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tập giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập gym hết bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập gym hết bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mua gói tập bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mua gói tập bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 1 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 1 tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Gym Cơ bản 1 Tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Gym Cơ bản 1 Tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói cơ bản bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói cơ bản bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 300 nghìn là gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 300 nghìn là gói nào?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 3 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 3 tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Gym Cao cấp 3 Tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Gym Cao cấp 3 Tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói cao cấp bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói cao cấp bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 800 nghìn là gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 800 nghìn là gói nào?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào rẻ nhất?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào rẻ nhất?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tập rẻ nhất là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tập rẻ nhất là gì?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tiết kiệm nhất là gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tiết kiệm nhất là gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói thấp tiền nhất?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói thấp tiền nhất?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào giá thấp nhất?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào giá thấp nhất?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào phù hợp cho người mới?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào phù hợp cho người mới?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người mới nên mua gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người mới nên mua gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nên chọn gói 1 tháng hay 3 tháng?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nên chọn gói 1 tháng hay 3 tháng?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào phù hợp với tôi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào phù hợp với tôi?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi mới tập gym nên chọn gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi mới tập gym nên chọn gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập thử thì nên mua gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập thử thì nên mua gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn gói như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn gói như thế nào?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao gia hạn gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao gia hạn gói tập?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn gia hạn gói gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn gia hạn gói gym',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói sắp hết hạn thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói sắp hết hạn thì làm sao?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói hết hạn có gia hạn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói hết hạn có gia hạn được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn ở đâu?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn online được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn online được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn tại quầy được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn tại quầy được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn trước ngày hết hạn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn trước ngày hết hạn được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hết hạn rồi có gia hạn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hết hạn rồi có gia hạn được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn gói 1 tháng thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn gói 1 tháng thế nào?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn gói 3 tháng thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn gói 3 tháng thế nào?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần thanh toán khi gia hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần thanh toán khi gia hạn không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn xong có tập ngay được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn xong có tập ngay được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hết hạn khi nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hết hạn khi nào?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao biết gói còn hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao biết gói còn hạn không?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kiểm tra ngày hết hạn ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kiểm tra ngày hết hạn ở đâu?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói của tôi còn bao lâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói của tôi còn bao lâu?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tập còn mấy ngày?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tập còn mấy ngày?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn xem hạn gói tập')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn xem hạn gói tập',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Membership expiration xem ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Membership expiration xem ở đâu?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ngày hết hạn gói tập là ngày nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ngày hết hạn gói tập là ngày nào?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao kiểm tra trạng thái gói?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao kiểm tra trạng thái gói?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Active nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Active nghĩa là gì?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Expired nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Expired nghĩa là gì?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tại sao gói của tôi hết hạn?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tại sao gói của tôi hết hạn?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói hết hạn có vào tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói hết hạn có vào tập được không?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi gói tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi gói tập được không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi gói')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi gói',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đổi từ gói 1 tháng sang 3 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đổi từ gói 1 tháng sang 3 tháng không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đổi từ gói 3 tháng sang gói khác không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đổi từ gói 3 tháng sang gói khác không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nâng cấp gói được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nâng cấp gói được không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn nâng cấp gói tập')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn nâng cấp gói tập',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể nâng cấp lên gói cao cấp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể nâng cấp lên gói cao cấp không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể hạ gói không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể hạ gói không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi package như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi package như thế nào?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Upgrade membership ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Upgrade membership ra sao?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thay đổi gói đang dùng được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thay đổi gói đang dùng được không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đang dùng gói này muốn đổi gói khác')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đang dùng gói này muốn đổi gói khác',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy gói tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy gói tập được không?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn hủy gói')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn hủy gói',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không tập nữa có hủy gói được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không tập nữa có hủy gói được không?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy membership như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy membership như thế nào?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cancel package ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cancel package ra sao?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảo lưu gói được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảo lưu gói được không?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán thế nào?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi thanh toán gói tập ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi thanh toán gói tập ở đâu?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán tại quầy được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán tại quầy được không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đóng tiền ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đóng tiền ở đâu?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Trả tiền gói tập như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Trả tiền gói tập như thế nào?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán tiền mặt không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán tiền mặt không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có trả bằng cash không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có trả bằng cash không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể trả tiền mặt không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể trả tiền mặt không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán xong bao lâu cập nhật?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán xong bao lâu cập nhật?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán rồi có tập ngay được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán rồi có tập ngay được không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần thanh toán trước khi tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần thanh toán trước khi tập không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký xong thanh toán ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký xong thanh toán ra sao?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn xong thanh toán thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn xong thanh toán thế nào?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán dịch vụ PT ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán dịch vụ PT ở đâu?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chuyển khoản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chuyển khoản không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng chuyển khoản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng chuyển khoản không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có banking không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có banking không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bank transfer không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bank transfer không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có số tài khoản ngân hàng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có số tài khoản ngân hàng không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có QR không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có QR không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán QR không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán QR không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quét mã QR không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quét mã QR không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mã QR chuyển khoản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mã QR chuyển khoản không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có QR Pay không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có QR Pay không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán online không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán online không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán qua app không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán qua app không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Momo không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Momo không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có VNPay không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có VNPay không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ví điện tử không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ví điện tử không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Visa không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Visa không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng Visa không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng Visa không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Mastercard không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Mastercard không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng Mastercard không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng Mastercard không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quẹt thẻ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quẹt thẻ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng thẻ ngân hàng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng thẻ ngân hàng không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thẻ tín dụng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thẻ tín dụng không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thẻ ghi nợ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thẻ ghi nợ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có card payment không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có card payment không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có POS không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có POS không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có trả góp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có trả góp không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hóa đơn không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán có hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán có hóa đơn không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có nhận hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có nhận hóa đơn không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có biên lai không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có biên lai không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có receipt không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có receipt không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem hóa đơn ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem hóa đơn ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn xem hóa đơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn xem hóa đơn',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem lịch sử hóa đơn thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem lịch sử hóa đơn thế nào?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn của tôi ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn của tôi ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Invoice detail xem ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Invoice detail xem ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn Pending nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn Pending nghĩa là gì?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn Paid nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn Paid nghĩa là gì?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn Cancelled nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn Cancelled nghĩa là gì?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tại sao hóa đơn của tôi Pending?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tại sao hóa đơn của tôi Pending?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn đã thanh toán ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn đã thanh toán ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn gói tập xem thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn gói tập xem thế nào?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn PT xem thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn PT xem thế nào?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'In hóa đơn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'In hóa đơn được không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn in hóa đơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn in hóa đơn',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể in biên lai không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể in biên lai không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi cần bản in hóa đơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi cần bản in hóa đơn',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có xuất file hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có xuất file hóa đơn không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hóa đơn VAT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hóa đơn VAT không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có xuất hóa đơn VAT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có xuất hóa đơn VAT không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hóa đơn đỏ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hóa đơn đỏ không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cần VAT thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cần VAT thì làm sao?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xuất hóa đơn công ty được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xuất hóa đơn công ty được không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn sai thông tin thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn sai thông tin thì làm sao?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có PT không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có huấn luyện viên cá nhân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có huấn luyện viên cá nhân không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Personal Trainer không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Personal Trainer không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có coach không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có coach không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có trainer riêng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có trainer riêng không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thuê PT như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thuê PT như thế nào?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn thuê PT')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn thuê PT',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký PT ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký PT ở đâu?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Book PT như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Book PT như thế nào?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt lịch PT ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt lịch PT ra sao?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký PT cần điều kiện gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký PT cần điều kiện gì?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần gói Gym để thuê PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần gói Gym để thuê PT không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không có gói Gym thuê PT được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không có gói Gym thuê PT được không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hội viên mới có thuê PT được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hội viên mới có thuê PT được không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá PT bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá PT bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thuê PT bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thuê PT bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảng giá PT?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảng giá PT?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chi phí thuê PT?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chi phí thuê PT?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT price là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT price là bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá PT 1 tháng bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá PT 1 tháng bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 1 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 1 tháng giá bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT cơ bản bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT cơ bản bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT 12 buổi bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT 12 buổi bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá PT 3 tháng bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá PT 3 tháng bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 3 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 3 tháng giá bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT cao cấp bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT cao cấp bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT 36 buổi bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT 36 buổi bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT có bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT có bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 1 tháng có mấy buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 1 tháng có mấy buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 3 tháng có mấy buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 3 tháng có mấy buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cơ bản có bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cơ bản có bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cao cấp có bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cao cấp có bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Một tháng PT tập bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Một tháng PT tập bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ba tháng PT tập bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ba tháng PT tập bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số buổi tập với PT là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số buổi tập với PT là bao nhiêu?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT package gồm bao nhiêu session?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT package gồm bao nhiêu session?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT sessions là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT sessions là gì?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói PT 12 buổi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói PT 12 buổi không?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói PT 36 buổi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói PT 36 buổi không?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT nào tốt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT nào tốt?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nên chọn PT nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nên chọn PT nào?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT nào phù hợp với tôi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT nào phù hợp với tôi?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT giảm cân là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT giảm cân là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT tăng cơ là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT tăng cơ là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cardio là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cardio là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT yoga là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT yoga là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT boxing là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT boxing là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT dinh dưỡng là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT dinh dưỡng là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có PT phục hồi thể lực không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có PT phục hồi thể lực không?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cho người mới là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cho người mới là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cho nữ có không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cho nữ có không?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT nam có không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT nam có không?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đổi PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đổi PT không?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi huấn luyện viên')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi huấn luyện viên',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không hợp PT thì đổi được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không hợp PT thì đổi được không?',
    N'Bạn có thể chọn PT theo mục tiêu: Quản lý cân nặng, Tăng cơ, Cardio, Yoga, Boxing, Dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có thiết bị gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có thiết bị gì?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có những máy tập nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có những máy tập nào?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị phòng gym gồm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị phòng gym gồm gì?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy chạy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy chạy không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy chạy bộ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy chạy bộ không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có treadmill không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có treadmill không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ghế tập ngực không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ghế tập ngực không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bench press không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bench press không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu cardio không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu cardio không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tập tạ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tập tạ không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy squat không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy squat không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có squat rack không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có squat rack không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có dumbbell không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có dumbbell không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tạ đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tạ đơn không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tạ tay không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tạ tay không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có barbell không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có barbell không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy tập chân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy tập chân không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy kéo xô không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy kéo xô không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy đạp xe không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy đạp xe không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy rowing không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy rowing không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy bị hỏng thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy bị hỏng thì làm sao?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị hỏng báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị hỏng báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Báo hỏng thiết bị ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Báo hỏng thiết bị ở đâu?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy tập không hoạt động thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy tập không hoạt động thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy chạy bị lỗi thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy chạy bị lỗi thì làm sao?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị không an toàn thì làm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị không an toàn thì làm gì?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạ bị hỏng thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạ bị hỏng thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ghế tập bị hỏng thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ghế tập bị hỏng thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể báo sự cố thiết bị không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể báo sự cố thiết bị không?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Report máy hỏng ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Report máy hỏng ở đâu?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi thấy máy tập nguy hiểm')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi thấy máy tập nguy hiểm',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy tập cần bảo trì thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy tập cần bảo trì thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị bẩn thì phản ánh ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị bẩn thì phản ánh ở đâu?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hướng dẫn sử dụng máy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hướng dẫn sử dụng máy không?',
    N'Nếu chưa biết sử dụng thiết bị, bạn nên hỏi nhân viên hoặc đăng ký PT để được hướng dẫn kỹ thuật an toàn, tránh chấn thương khi tập luyện.',
    N'Equipment',
    N'hướng dẫn sử dụng máy, huong dan su dung may, dùng thiết bị, dung thiet bi, an toàn, an toan, kỹ thuật, ky thuat, người mới, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không biết dùng máy thì hỏi ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không biết dùng máy thì hỏi ai?',
    N'Nếu chưa biết sử dụng thiết bị, bạn nên hỏi nhân viên hoặc đăng ký PT để được hướng dẫn kỹ thuật an toàn, tránh chấn thương khi tập luyện.',
    N'Equipment',
    N'hướng dẫn sử dụng máy, huong dan su dung may, dùng thiết bị, dung thiet bi, an toàn, an toan, kỹ thuật, ky thuat, người mới, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có phòng tắm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có phòng tắm không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có nhà tắm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có nhà tắm không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có shower không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có shower không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập xong có chỗ tắm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập xong có chỗ tắm không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tắm riêng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tắm riêng không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có phòng thay đồ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có phòng thay đồ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có changing room không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có changing room không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có nhà vệ sinh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có nhà vệ sinh không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có restroom không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có restroom không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu vệ sinh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu vệ sinh không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có locker không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có locker không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tủ đồ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tủ đồ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chỗ gửi đồ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chỗ gửi đồ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tủ cá nhân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tủ cá nhân không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi đồ ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi đồ ở đâu?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gửi xe không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gửi xe không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bãi xe không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bãi xe không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chỗ để xe máy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chỗ để xe máy không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chỗ để ô tô không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chỗ để ô tô không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi xe có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi xe có mất phí không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có wifi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có wifi không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Wifi phòng gym là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Wifi phòng gym là gì?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mật khẩu wifi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mật khẩu wifi không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có internet không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có internet không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy lạnh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy lạnh không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có điều hòa không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có điều hòa không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng tập có mát không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng tập có mát không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có nước uống không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có nước uống không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bình nước không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bình nước không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bán nước không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bán nước không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khăn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khăn không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khăn tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khăn tập không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cho thuê khăn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cho thuê khăn không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu nghỉ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu nghỉ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ghế chờ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ghế chờ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mấy giờ mở?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mấy giờ mở?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym mở cửa lúc mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym mở cửa lúc mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym mở lúc nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym mở lúc nào?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giờ mở cửa là mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giờ mở cửa là mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sáng mấy giờ mở cửa?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sáng mấy giờ mở cửa?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mấy giờ đóng?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mấy giờ đóng?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym đóng cửa lúc mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym đóng cửa lúc mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym đóng lúc nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym đóng lúc nào?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tối mấy giờ đóng cửa?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tối mấy giờ đóng cửa?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giờ đóng cửa là mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giờ đóng cửa là mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thời gian hoạt động của phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thời gian hoạt động của phòng gym?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lịch mở cửa hằng ngày?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lịch mở cửa hằng ngày?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giờ hoạt động hôm nay?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giờ hoạt động hôm nay?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym mở từ mấy giờ đến mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym mở từ mấy giờ đến mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở buổi sáng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở buổi sáng không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở buổi tối không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở buổi tối không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tập sau 21h được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tập sau 21h được không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tập lúc 5h sáng được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tập lúc 5h sáng được không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở Chủ nhật không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở Chủ nhật không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chủ nhật phòng gym có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chủ nhật phòng gym có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở cuối tuần không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở cuối tuần không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thứ bảy có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thứ bảy có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cuối tuần tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cuối tuần tập được không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ngày lễ có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ngày lễ có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở ngày lễ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở ngày lễ không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lịch ngày lễ thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lịch ngày lễ thế nào?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tết có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tết có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở Tết không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở Tết không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Địa chỉ phòng gym ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Địa chỉ phòng gym ở đâu?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Địa chỉ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Địa chỉ',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym nằm ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym nằm ở đâu?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Vị trí phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Vị trí phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym ở khu nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym ở khu nào?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chỉ đường đến phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chỉ đường đến phòng gym',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Google Map phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Google Map phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Google Map không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Google Map không?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Map đến phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Map đến phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tìm phòng gym trên bản đồ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tìm phòng gym trên bản đồ',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym ở Hòa Lạc đúng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym ở Hòa Lạc đúng không?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hotline là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hotline là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số điện thoại phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số điện thoại phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Liên hệ qua số nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Liên hệ qua số nào?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gọi phòng gym số nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gọi phòng gym số nào?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có số tư vấn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có số tư vấn không?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Email hỗ trợ là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Email hỗ trợ là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mail hỗ trợ là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mail hỗ trợ là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi email cho phòng gym ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi email cho phòng gym ở đâu?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Support email là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Support email là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Facebook phòng gym là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Facebook phòng gym là gì?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có fanpage không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có fanpage không?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Fanpage phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Fanpage phòng gym?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Facebook ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Facebook ở đâu?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Instagram không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Instagram không?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Zalo không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Zalo không?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Website phòng gym là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Website phòng gym là gì?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Trang web phòng gym ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Trang web phòng gym ở đâu?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn góp ý')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn góp ý',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi góp ý như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi góp ý như thế nào?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có đề xuất cho phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có đề xuất cho phòng gym',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn phản hồi dịch vụ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn phản hồi dịch vụ',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đánh giá phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đánh giá phòng gym',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đánh giá dịch vụ ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đánh giá dịch vụ ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Review phòng gym thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Review phòng gym thế nào?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn khen nhân viên')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn khen nhân viên',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn khen PT')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn khen PT',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi không hài lòng thì phản ánh ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi không hài lòng thì phản ánh ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khiếu nại ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khiếu nại ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn khiếu nại')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn khiếu nại',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phàn nàn dịch vụ thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phàn nàn dịch vụ thế nào?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn báo trải nghiệm không tốt')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn báo trải nghiệm không tốt',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về thiết bị ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về thiết bị ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về vệ sinh ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về vệ sinh ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về cơ sở vật chất')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về cơ sở vật chất',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về thái độ phục vụ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về thái độ phục vụ',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về lịch PT')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về lịch PT',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khiếu nại có được phản hồi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khiếu nại có được phản hồi không?',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao lâu xử lý khiếu nại?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao lâu xử lý khiếu nại?',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi feedback xong ai xử lý?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi feedback xong ai xử lý?',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn theo dõi phản hồi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn theo dõi phản hồi',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách hoàn tiền như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách hoàn tiền như thế nào?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hoàn tiền không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hoàn tiền không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn hoàn tiền')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn hoàn tiền',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Refund được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Refund được không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không tập nữa có lấy lại tiền không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không tập nữa có lấy lại tiền không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách hủy gói là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách hủy gói là gì?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy gói có được hoàn tiền không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy gói có được hoàn tiền không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy gói có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy gói có mất phí không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy membership ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy membership ra sao?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách bảo lưu thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách bảo lưu thế nào?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảo lưu gói được bao lâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảo lưu gói được bao lâu?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đóng băng gói có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đóng băng gói có mất phí không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạm dừng gói có được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạm dừng gói có được không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách chuyển nhượng thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách chuyển nhượng thế nào?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chuyển nhượng gói có điều kiện gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chuyển nhượng gói có điều kiện gì?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sang tên gói có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sang tên gói có mất phí không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể chuyển gói cho bạn bè không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể chuyển gói cho bạn bè không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách hội viên là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách hội viên là gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Quy định hội viên gồm những gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Quy định hội viên gồm những gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nội quy phòng tập là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nội quy phòng tập là gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đi tập cần tuân thủ gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đi tập cần tuân thủ gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quy định trang phục không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quy định trang phục không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được mang đồ ăn vào phòng tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được mang đồ ăn vào phòng tập không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được quay video không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được quay video không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được dẫn bạn vào tập cùng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được dẫn bạn vào tập cùng không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khách vãng lai có được vào không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khách vãng lai có được vào không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chính sách cho người bị chấn thương không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chính sách cho người bị chấn thương không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bị ốm có được bảo lưu không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bị ốm có được bảo lưu không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Quên mật khẩu thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Quên mật khẩu thì làm sao?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi quên mật khẩu')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi quên mật khẩu',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Forgot password ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Forgot password ở đâu?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt lại mật khẩu như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt lại mật khẩu như thế nào?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Reset password thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Reset password thế nào?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không đăng nhập được')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không đăng nhập được',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tại sao tôi không đăng nhập được?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tại sao tôi không đăng nhập được?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng nhập bị lỗi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng nhập bị lỗi',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sai mật khẩu thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sai mật khẩu thì làm sao?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tài khoản bị khóa thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tài khoản bị khóa thì làm sao?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không nhận được email xác thực')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không nhận được email xác thực',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần xác thực email không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần xác thực email không?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Verify email như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Verify email như thế nào?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kích hoạt tài khoản ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kích hoạt tài khoản ở đâu?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi chưa kích hoạt tài khoản')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi chưa kích hoạt tài khoản',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi mật khẩu như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi mật khẩu như thế nào?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi mật khẩu')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi mật khẩu',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Change password ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Change password ở đâu?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mật khẩu mới đặt ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mật khẩu mới đặt ở đâu?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi password được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi password được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi email được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi email được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi email')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi email',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sửa email tài khoản')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sửa email tài khoản',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Email sai thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Email sai thì làm sao?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật email mới')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật email mới',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi số điện thoại được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi số điện thoại được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi số điện thoại')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi số điện thoại',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sửa phone tài khoản')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sửa phone tài khoản',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số điện thoại sai thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số điện thoại sai thì làm sao?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật số điện thoại mới')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật số điện thoại mới',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật hồ sơ cá nhân ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật hồ sơ cá nhân ở đâu?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sửa thông tin cá nhân')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sửa thông tin cá nhân',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi tên tài khoản được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi tên tài khoản được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi ảnh đại diện được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi ảnh đại diện được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật profile như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật profile như thế nào?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tài khoản của tôi có thông tin gói tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tài khoản của tôi có thông tin gói tập không?',
    N'Tài khoản giúp bạn theo dõi thông tin cá nhân, gói tập, hóa đơn và thông báo. Với các vấn đề bảo mật, trùng thông tin hoặc yêu cầu ngừng sử dụng tài khoản, bạn vui lòng liên hệ quầy lễ tân để được kiểm tra.',
    N'Account',
    N'tài khoản, tai khoan, account, profile, thông tin hội viên, logout, đăng xuất, bảo mật tài khoản, email trùng, phone trùng, xóa tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem thông tin hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem thông tin hội viên ở đâu?',
    N'Tài khoản giúp bạn theo dõi thông tin cá nhân, gói tập, hóa đơn và thông báo. Với các vấn đề bảo mật, trùng thông tin hoặc yêu cầu ngừng sử dụng tài khoản, bạn vui lòng liên hệ quầy lễ tân để được kiểm tra.',
    N'Account',
    N'tài khoản, tai khoan, account, profile, thông tin hội viên, logout, đăng xuất, bảo mật tài khoản, email trùng, phone trùng, xóa tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem profile hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem profile hội viên ở đâu?',
    N'Tài khoản giúp bạn theo dõi thông tin cá nhân, gói tập, hóa đơn và thông báo. Với các vấn đề bảo mật, trùng thông tin hoặc yêu cầu ngừng sử dụng tài khoản, bạn vui lòng liên hệ quầy lễ tân để được kiểm tra.',
    N'Account',
    N'tài khoản, tai khoan, account, profile, thông tin hội viên, logout, đăng xuất, bảo mật tài khoản, email trùng, phone trùng, xóa tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym phù hợp cho người mới không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym phù hợp cho người mới không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người mới tập nên bắt đầu thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người mới tập nên bắt đầu thế nào?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi mới tập gym cần chuẩn bị gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi mới tập gym cần chuẩn bị gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lần đầu đến phòng gym cần làm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lần đầu đến phòng gym cần làm gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đi tập cần mang gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đi tập cần mang gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mang giày riêng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mang giày riêng không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mang khăn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mang khăn không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mang nước không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mang nước không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nên mặc đồ gì khi tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nên mặc đồ gì khi tập?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ai hướng dẫn người mới không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ai hướng dẫn người mới không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi chưa biết tập thì hỏi ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi chưa biết tập thì hỏi ai?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập sai kỹ thuật thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập sai kỹ thuật thì làm sao?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần thuê PT khi mới tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần thuê PT khi mới tập không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn giảm cân thì nên tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn giảm cân thì nên tập gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tăng cơ thì nên tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tăng cơ thì nên tập gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn cải thiện tim mạch thì tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn cải thiện tim mạch thì tập gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập yoga thì chọn ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập yoga thì chọn ai?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập boxing thì chọn ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập boxing thì chọn ai?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tư vấn dinh dưỡng')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tư vấn dinh dưỡng',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn phục hồi thể lực')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn phục hồi thể lực',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập nhẹ nhàng')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập nhẹ nhàng',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập cường độ cao')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập cường độ cao',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có những khu vực nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có những khu vực nào?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym rooms gồm những gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym rooms gồm những gì?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tạ tự do không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tạ tự do không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tập ngực không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tập ngực không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tập chân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tập chân không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu yoga không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu yoga không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu boxing không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu boxing không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có phòng riêng cho PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có phòng riêng cho PT không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lớp học nhóm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lớp học nhóm không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lớp yoga không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lớp yoga không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lớp cardio không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lớp cardio không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lịch lớp học không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lịch lớp học không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lịch trình tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lịch trình tập không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn xem lịch tập')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn xem lịch tập',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quy định vệ sinh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quy định vệ sinh không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập xong có cần lau máy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập xong có cần lau máy không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần cất tạ sau khi tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần cất tạ sau khi tập không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được chiếm máy lâu không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được chiếm máy lâu không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được mang trẻ em vào không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được mang trẻ em vào không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được mang thú cưng vào không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được mang thú cưng vào không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được chụp ảnh trong phòng gym không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được chụp ảnh trong phòng gym không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được quay video tập luyện không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được quay video tập luyện không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được ăn uống trong khu tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được ăn uống trong khu tập không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạm biệt')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạm biệt',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bye')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bye',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Goodbye')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Goodbye',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hẹn gặp lại')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hẹn gặp lại',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn bạn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn bạn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanks')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanks',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thank you')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thank you',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ok cảm ơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ok cảm ơn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Được rồi cảm ơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Được rồi cảm ơn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi hiểu rồi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi hiểu rồi',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không cần nữa')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không cần nữa',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi hỏi sau')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi hỏi sau',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kết thúc chat')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kết thúc chat',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Dừng chat')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Dừng chat',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạm thời vậy thôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạm thời vậy thôi',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn chatbot')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn chatbot',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn phòng gym',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thời tiết hôm nay thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thời tiết hôm nay thế nào?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'thời tiết, thoi tiet, weather, hôm nay, dự báo',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá vàng hôm nay bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá vàng hôm nay bao nhiêu?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'giá vàng, gia vang, gold price, vàng, sjc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá đô la hôm nay?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá đô la hôm nay?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'đô la, dollar, usd, tỷ giá, exchange rate',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'AI là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'AI là gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'ai là gì, artificial intelligence, trí tuệ nhân tạo',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Viết code Java giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Viết code Java giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'java, code, lập trình, programming, servlet',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm bài tập giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm bài tập giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bài tập, homework, assignment, làm hộ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kết quả bóng đá hôm nay?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kết quả bóng đá hôm nay?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bóng đá, bong da, football, soccer, kết quả',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lịch thi đấu World Cup?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lịch thi đấu World Cup?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'world cup, lịch thi đấu, football schedule',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Facebook của tôi bị khóa')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Facebook của tôi bị khóa',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'facebook, khóa tài khoản, mạng xã hội',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Google là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Google là gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'google, search engine, tìm kiếm',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mua điện thoại nào tốt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mua điện thoại nào tốt?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'điện thoại, phone, smartphone, mua gì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn mua laptop')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn mua laptop',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'laptop, máy tính, computer, tư vấn mua',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt vé máy bay giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt vé máy bay giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'vé máy bay, flight, ticket, travel',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt khách sạn giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt khách sạn giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'khách sạn, hotel, booking, travel',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hôm nay ăn gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hôm nay ăn gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'ăn gì, món ăn, food, dinner',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cách nấu phở')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cách nấu phở',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'nấu ăn, phở, recipe, cooking',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn chứng khoán')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn chứng khoán',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'chứng khoán, stock, cổ phiếu, đầu tư',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn tiền ảo')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn tiền ảo',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bitcoin, crypto, tiền ảo, coin',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem tử vi hôm nay')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem tử vi hôm nay',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'tử vi, horoscope, bói toán',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Dịch tiếng Anh giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Dịch tiếng Anh giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'dịch, translate, english, tiếng anh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Viết bài văn giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Viết bài văn giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bài văn, essay, viết văn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạo ảnh AI giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạo ảnh AI giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'tạo ảnh, image generation, ai image',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kể chuyện cười')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kể chuyện cười',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'chuyện cười, joke, vui',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nghe nhạc được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nghe nhạc được không?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'nhạc, music, bài hát, song',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tải video YouTube giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tải video YouTube giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'youtube, download video, tải video',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mật khẩu wifi nhà tôi là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mật khẩu wifi nhà tôi là gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'wifi nhà, mật khẩu riêng, password',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tìm việc làm giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tìm việc làm giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'việc làm, job, tuyển dụng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn pháp luật')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn pháp luật',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'pháp luật, legal, luật sư',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn bệnh án')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn bệnh án',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bệnh án, medical, doctor, sức khỏe bệnh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mua bảo hiểm nào tốt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mua bảo hiểm nào tốt?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bảo hiểm, insurance, mua bảo hiểm',
    N'Active'
);

END;
GO

GO
USE [GymCenterManagement]
GO
UPDATE u
SET u.PasswordHash = '5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6'
FROM [dbo].[Users] u
INNER JOIN [dbo].[UserRoles] ur ON u.UserID = ur.UserID
WHERE ur.RoleID = 4;
GO

USE [GymCenterManagement]
GO

-- Contextual FAQ additions for chatbot.
-- Append-only block: keeps existing FAQ data unchanged and inserts only missing questions.
IF OBJECT_ID(N'dbo.FAQ', N'U') IS NOT NULL
BEGIN
    DECLARE @ContextualFAQAdditions TABLE
    (
        question NVARCHAR(500) NOT NULL,
        answer NVARCHAR(MAX) NOT NULL,
        category NVARCHAR(100) NULL,
        keywords NVARCHAR(1000) NULL,
        status NVARCHAR(20) NOT NULL
    );

    INSERT INTO @ContextualFAQAdditions (question, answer, category, keywords, status)
    VALUES
    (
        N'Cầu thủ bóng đá có tập gym không?',
        N'Có. Cầu thủ bóng đá thường tập gym để tăng sức mạnh, sức bền, tốc độ, khả năng bật nhảy và hạn chế chấn thương. Nếu bạn tập gym để hỗ trợ đá bóng, nên kết hợp bài tập chân, core, sức bền và linh hoạt. Bạn có thể đăng ký gói gym hoặc thuê PT để được hướng dẫn lịch tập phù hợp với mục tiêu.',
        N'Training Advice',
        N'cầu thủ bóng đá, cau thu bong da, bóng đá tập gym, bong da tap gym, đá bóng tập gym, da bong tap gym, football, soccer, sức mạnh, sức bền, tốc độ, chấn thương',
        N'Active'
    ),
    (
        N'Tôi muốn đăng ký gói tập 1 tháng với 36 buổi tập có được không?',
        N'Hiện cấu hình gói trong hệ thống không có gói 1 tháng gồm 36 buổi. Gói Gym Cơ bản 1 Tháng là gói tập gym theo thời hạn 1 tháng. Với PT, gói PT Cơ bản 1 Tháng gồm 12 buổi, còn gói PT Cao cấp 3 Tháng gồm 36 buổi. Nếu bạn muốn 36 buổi, vui lòng chọn gói PT 3 tháng hoặc liên hệ lễ tân để được tư vấn.',
        N'Personal Trainer',
        N'1 tháng 36 buổi, 1 thang 36 buoi, 36 buổi trong 1 tháng, 36 buoi trong 1 thang, pt 36 buổi, pt cao cấp, gym 1 tháng 36 buổi',
        N'Active'
    ),
    (
        N'Gói gym 1 tháng có 36 buổi không?',
        N'Không. Gói Gym Cơ bản 1 Tháng là gói gym theo thời hạn 1 tháng, không phải gói 36 buổi. Số buổi 36 thuộc gói PT Cao cấp 3 Tháng. Nếu bạn muốn tập 36 buổi với PT, bạn nên chọn gói PT 3 tháng hoặc liên hệ lễ tân để kiểm tra thêm.',
        N'Membership Package',
        N'gói gym 1 tháng 36 buổi, goi gym 1 thang 36 buoi, gym 36 buổi, gói gym cơ bản, gói pt cao cấp, pt 36 buổi',
        N'Active'
    ),
    (
        N'Gói PT 1 tháng có 36 buổi không?',
        N'Không. Theo cấu hình hiện tại, gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng mới gồm 36 buổi. Nếu bạn cần 36 buổi tập với PT, hãy chọn gói PT 3 tháng hoặc liên hệ lễ tân để được tư vấn.',
        N'Membership Package',
        N'gói pt 1 tháng 36 buổi, goi pt 1 thang 36 buoi, pt 1 tháng, pt 36 buổi, 12 buổi, 36 buổi, personal trainer, pt cơ bản, pt cao cấp',
        N'Active'
    ),
    (
        N'Gói 1 tháng 36 buổi có tồn tại trong hệ thống không?',
        N'Hiện hệ thống có Gói Gym Cơ bản 1 Tháng và Gói Gym Cao cấp 3 Tháng. Gói 1 tháng 36 buổi không có trong cấu hình hiện tại. Nếu bạn đang hỏi về PT thì gói PT Cơ bản 1 Tháng gồm 12 buổi, còn gói PT Cao cấp 3 Tháng gồm 36 buổi. Bạn vui lòng chọn đúng gói hoặc liên hệ lễ tân để được hỗ trợ.',
        N'Personal Trainer',
        N'1 tháng 36 buổi, 1 thang 36 buoi, gym 1 tháng 36 buổi, pt 36 buổi, không có gói 1 tháng 36 buổi, 12 buổi, 36 buổi',
        N'Active'
    ),
    (
        N'Người chơi bóng đá nên tập gym như thế nào?',
        N'Người chơi bóng đá nên tập gym để hỗ trợ sức mạnh chân, core, sức bền, tốc độ và khả năng phòng tránh chấn thương. Nên ưu tiên bài tập chân, core, sức bền, linh hoạt và không tập quá nặng sát ngày đá bóng. Nếu cần lịch tập phù hợp hơn, bạn có thể đăng ký gói gym hoặc thuê PT để được hướng dẫn.',
        N'Training Advice',
        N'người chơi bóng đá, nguoi choi bong da, đá bóng tập gym, da bong tap gym, gym cho bóng đá, football gym, soccer gym, sức mạnh chân, core, sức bền, tốc độ, chấn thương',
        N'Active'
    ),
    (
        N'Tập gym có làm chậm tốc độ đá bóng không?',
        N'Không nhất thiết. Nếu tập đúng cách, gym có thể hỗ trợ tốc độ, sức mạnh và sức bền khi đá bóng. Người tập nên tránh tập quá tải hoặc tập nặng sát ngày thi đấu. Nếu bạn cần lịch tập cân bằng giữa gym và bóng đá, có thể tham khảo PT tại phòng gym.',
        N'Training Advice',
        N'tập gym làm chậm, tap gym lam cham, tốc độ đá bóng, toc do da bong, bóng đá, football, soccer, tập chân, tập nặng, lịch tập bóng đá',
        N'Active'
    ),
    (
        N'Chơi bóng rổ có nên tập gym không?',
        N'Có. Người chơi bóng rổ có thể tập gym để cải thiện sức mạnh chân, core, sức bật, sức bền và khả năng kiểm soát cơ thể. Nên kết hợp bài tập sức mạnh, linh hoạt và phục hồi. Nếu bạn muốn tập theo mục tiêu bóng rổ, có thể đăng ký gói gym hoặc thuê PT để được hướng dẫn.',
        N'Training Advice',
        N'bóng rổ, bong ro, basketball, tập gym bóng rổ, sức bật, bật nhảy, core, sức mạnh chân, thể lực',
        N'Active'
    ),
    (
        N'Người chạy bộ có nên tập gym không?',
        N'Có. Người chạy bộ có thể tập gym để cải thiện sức mạnh cơ chân, core, độ ổn định khớp và hạn chế chấn thương. Nên chọn bài tập bổ trợ thay vì chỉ tập nặng. Nếu cần lịch tập phù hợp với chạy bộ, bạn có thể tham khảo PT.',
        N'Training Advice',
        N'chạy bộ, chay bo, running, runner, tập gym chạy bộ, core, cơ chân, sức bền, chấn thương, bổ trợ chạy bộ',
        N'Active'
    ),
    (
        N'Tôi muốn tăng thể lực thì nên chọn gói nào?',
        N'Nếu mục tiêu là tăng thể lực chung, bạn có thể bắt đầu với Gói Gym Cơ bản 1 Tháng để làm quen. Nếu cần người hướng dẫn bài tập, theo dõi tiến độ và điều chỉnh lịch tập, bạn có thể chọn thêm gói PT. Gói PT Cơ bản 1 Tháng gồm 12 buổi, gói PT Cao cấp 3 Tháng gồm 36 buổi.',
        N'Membership Package',
        N'tăng thể lực, tang the luc, cải thiện thể lực, sức bền, chọn gói nào, gói gym, gói pt, 12 buổi, 36 buổi',
        N'Active'
    ),
    (
        N'Người mới bắt đầu nên chọn gói gym nào?',
        N'Người mới bắt đầu có thể chọn Gói Gym Cơ bản 1 Tháng để làm quen với phòng tập và thiết bị. Nếu bạn chưa biết kỹ thuật hoặc muốn có lịch tập rõ ràng, có thể thuê PT; gói PT Cơ bản 1 Tháng gồm 12 buổi.',
        N'Membership Package',
        N'người mới bắt đầu, nguoi moi bat dau, mới tập gym, beginner, chọn gói gym, gói cơ bản, gói pt cơ bản, chưa biết tập',
        N'Active'
    ),
    (
        N'Tôi chưa biết dùng máy tập thì nên đăng ký gì?',
        N'Nếu bạn chưa biết dùng máy tập, bạn có thể đăng ký gói gym để sử dụng phòng tập và cân nhắc thuê PT để được hướng dẫn kỹ thuật an toàn. Gói PT Cơ bản 1 Tháng gồm 12 buổi, phù hợp cho người mới cần được hướng dẫn.',
        N'Equipment',
        N'chưa biết dùng máy, máy tập, người mới, hướng dẫn kỹ thuật, dùng thiết bị, an toàn tập luyện',
        N'Active'
    ),
    (
        N'Tôi muốn giảm cân thì nên chọn gói gym hay PT?',
        N'Nếu bạn muốn tự tập để giảm cân, có thể bắt đầu với gói gym. Nếu cần lịch tập, kỹ thuật và theo dõi sát hơn, bạn nên cân nhắc thuê PT. PT có thể hỗ trợ xây dựng lịch tập phù hợp với mục tiêu giảm cân của bạn.',
        N'Membership Package',
        N'giảm cân, giam can, chọn gói gym hay PT, gói gym, gói pt, thuê pt, lịch tập giảm cân',
        N'Active'
    ),
    (
        N'Tôi muốn tăng cơ thì nên chọn gói gym hay PT?',
        N'Nếu bạn đã biết kỹ thuật và có thể tự tập, gói gym có thể phù hợp. Nếu bạn cần người hướng dẫn bài tập, chỉnh kỹ thuật và theo dõi tiến độ tăng cơ, nên cân nhắc thuê PT.',
        N'Membership Package',
        N'tăng cơ, tang co, chọn gói gym hay PT, gói gym, gói pt, thuê pt, lịch tập tăng cơ',
        N'Active'
    ),
    (
        N'Thể lực yếu thì có nên thuê PT không?',
        N'Bạn có thể tự tập nhẹ nhàng với gói gym nếu đã biết cách tập. Nếu cần lịch tập phù hợp với thể lực, tránh tập sai kỹ thuật hoặc muốn được theo dõi sát hơn, bạn có thể thuê PT.',
        N'Training Advice',
        N'thể lực yếu, the luc yeu, tập nhẹ có PT, tap nhe co PT, thuê PT khi yếu, người mới, lịch tập nhẹ, an toàn tập luyện',
        N'Active'
    ),
    (
        N'Nghỉ tập lâu rồi quay lại gym nên bắt đầu thế nào?',
        N'Bạn có thể tập gym để phục hồi thể lực sau thời gian nghỉ, nhưng nên bắt đầu với cường độ vừa phải và tăng dần. Nếu đã nghỉ lâu hoặc có vấn đề sức khỏe, bạn nên hỏi ý kiến bác sĩ trước khi tập và có thể thuê PT để được hướng dẫn an toàn.',
        N'Training Advice',
        N'nghỉ tập lâu, nghi tap lau, quay lại gym, phục hồi sau nghỉ, tập lại, cường độ nhẹ, bác sĩ, PT hướng dẫn',
        N'Active'
    ),
    (
        N'Phụ nữ có nên tập gym không?',
        N'Có. Phụ nữ có thể tập gym để cải thiện sức khỏe, vóc dáng, sức bền và thể lực. Nên chọn cường độ phù hợp với mục tiêu cá nhân. Nếu chưa biết bắt đầu, bạn có thể hỏi nhân viên hoặc thuê PT để được hướng dẫn.',
        N'Training Advice',
        N'phụ nữ tập gym, phu nu tap gym, nữ tập gym, sức khỏe, vóc dáng, giảm cân, tăng cơ, PT',
        N'Active'
    ),
    (
        N'Người lớn tuổi có tập gym được không?',
        N'Người lớn tuổi có thể tập gym nếu sức khỏe phù hợp, nhưng nên chọn bài tập nhẹ, an toàn và hỏi ý kiến bác sĩ khi cần. PT có thể hỗ trợ điều chỉnh bài tập theo thể lực.',
        N'Health Safety',
        N'người lớn tuổi, nguoi lon tuoi, người già, tập gym, bài tập nhẹ, an toàn, bác sĩ, PT',
        N'Active'
    ),
    (
        N'Tôi bị đau lưng có nên tập gym không?',
        N'Nếu bạn đang bị đau lưng hoặc có vấn đề sức khỏe, nên hỏi ý kiến bác sĩ trước khi tập. Phòng gym không thay thế tư vấn y tế. Sau khi được phép tập, bạn có thể nhờ PT hướng dẫn bài phù hợp và tránh các động tác gây đau.',
        N'Health Safety',
        N'đau lưng, dau lung, tập gym đau lưng, bác sĩ, chấn thương, an toàn, PT hướng dẫn',
        N'Active'
    ),
    (
        N'Tôi bị chấn thương có nên tập gym không?',
        N'Nếu bạn đang bị chấn thương, nên hỏi ý kiến bác sĩ hoặc chuyên gia y tế trước khi tập. Chatbot và phòng gym không thay thế tư vấn y tế. Sau khi được phép tập, bạn có thể trao đổi với PT để chọn bài phù hợp.',
        N'Health Safety',
        N'chấn thương, chan thuong, bị thương, tập gym, bác sĩ, tư vấn y tế, PT hướng dẫn',
        N'Active'
    ),
    (
        N'Tôi muốn tập thử một ngày được không?',
        N'Chính sách tập thử có thể thay đổi theo thời điểm. Bạn vui lòng liên hệ lễ tân qua email hoặc số điện thoại để được xác nhận trước khi đến phòng tập.',
        N'General Gym Information',
        N'tập thử, tap thu, tập thử một ngày, trial, dùng thử phòng gym, trải nghiệm gym, liên hệ lễ tân',
        N'Active'
    ),
    (
        N'Tôi bận chỉ tập buổi tối thì đăng ký được không?',
        N'Bạn có thể đăng ký gói tập nếu thời gian tập buổi tối phù hợp với giờ mở cửa của phòng gym. Vui lòng kiểm tra giờ hoạt động hoặc liên hệ lễ tân để được xác nhận lịch phù hợp.',
        N'Opening Hours',
        N'tập buổi tối, tap buoi toi, bận ban ngày, lịch tập tối, giờ mở cửa, gói tập buổi tối',
        N'Active'
    ),
    (
        N'Gói Gym và gói PT khác nhau thế nào?',
        N'Gói Gym cho phép bạn sử dụng phòng tập theo thời hạn gói. Gói PT là gói tập với huấn luyện viên cá nhân và thường có số buổi cụ thể, ví dụ PT Cơ bản 1 Tháng gồm 12 buổi và PT Cao cấp 3 Tháng gồm 36 buổi.',
        N'Membership Package',
        N'gói gym và gói pt, gym khác pt, khác nhau, sử dụng phòng tập, huấn luyện viên cá nhân, 12 buổi, 36 buổi',
        N'Active'
    ),
    (
        N'36 buổi là gói Gym hay gói PT?',
        N'36 buổi là số buổi của gói PT Cao cấp 3 Tháng, không phải gói Gym. Gói Gym được quản lý theo thời hạn như 1 tháng hoặc 3 tháng, còn gói PT được quản lý theo số buổi tập với huấn luyện viên cá nhân.',
        N'Personal Trainer',
        N'36 buổi, 36 buoi, gói nào, gói gym hay pt, pt cao cấp, gym theo tháng, pt theo buổi',
        N'Active'
    ),
    (
        N'12 buổi là gói gì?',
        N'12 buổi là số buổi của gói PT Cơ bản 1 Tháng. Đây là gói tập với huấn luyện viên cá nhân, không phải gói Gym sử dụng phòng tập thông thường.',
        N'Personal Trainer',
        N'12 buổi, 12 buoi, gói gì, gói PT cơ bản, PT 1 tháng, huấn luyện viên cá nhân',
        N'Active'
    ),
    (
        N'Gói 1 tháng là Gym hay PT?',
        N'Hệ thống có cả gói Gym Cơ bản 1 Tháng và gói PT Cơ bản 1 Tháng. Gói Gym là sử dụng phòng tập theo thời hạn; gói PT là tập với huấn luyện viên cá nhân và gồm 12 buổi.',
        N'Membership Package',
        N'gói 1 tháng, goi 1 thang, gym 1 tháng, pt 1 tháng, gói gym cơ bản, gói pt cơ bản, 12 buổi',
        N'Active'
    ),
    (
        N'Loại cao cấp 3 tháng là Gym hay PT?',
        N'Hệ thống có Gói Gym Cao cấp 3 Tháng và Gói PT Cao cấp 3 Tháng. Gói Gym là sử dụng phòng tập theo thời hạn, còn gói PT Cao cấp 3 Tháng gồm 36 buổi tập với huấn luyện viên cá nhân.',
        N'General Gym Information',
        N'cao cấp 3 tháng, gym cao cấp, pt cao cấp, 36 buổi, 3 tháng, gym hay pt',
        N'Active'
    ),
    (
        N'Có thể dùng 36 buổi PT trong 1 tháng không?',
        N'Hiện gói 36 buổi thuộc gói PT Cao cấp 3 Tháng. Việc tập dồn trong 1 tháng có thể phụ thuộc vào lịch PT và chính sách của phòng gym. Bạn nên liên hệ lễ tân để được kiểm tra và tư vấn trước khi đăng ký.',
        N'Membership Management',
        N'dùng 36 buổi PT trong 1 tháng, 36 buổi PT 1 tháng, tập dồn, PT 36 buổi, PT cao cấp 3 tháng, lịch PT, chính sách',
        N'Active'
    ),
    (
        N'Gói PT 3 tháng có thể tập dồn trong 1 tháng không?',
        N'Gói PT Cao cấp 3 Tháng gồm 36 buổi và được thiết kế theo thời hạn 3 tháng. Việc tập dồn trong 1 tháng cần được kiểm tra theo lịch PT và chính sách hiện tại. Bạn vui lòng liên hệ lễ tân để được xác nhận.',
        N'Membership Management',
        N'pt 3 tháng tập dồn, tập dồn 1 tháng, 36 buổi, lịch PT, chính sách PT, lễ tân',
        N'Active'
    ),
    (
        N'Không chọn loại cao cấp thì dùng loại cơ bản 1 tháng được không?',
        N'Bạn có thể đăng ký Gói Gym Cơ bản 1 Tháng nếu muốn sử dụng phòng tập trong 1 tháng. Nếu bạn hỏi về số buổi PT, gói PT Cơ bản 1 Tháng gồm 12 buổi, còn 36 buổi thuộc gói PT Cao cấp 3 Tháng.',
        N'General Gym Information',
        N'không chọn cao cấp, loại cơ bản 1 tháng, gym cơ bản, pt cơ bản, 12 buổi, 36 buổi',
        N'Active'
    ),
    (
        N'Tôi muốn đổi từ gói cao cấp sang gói cơ bản được không?',
        N'Việc đổi gói phụ thuộc vào tình trạng gói hiện tại và chính sách của phòng gym. Bạn vui lòng liên hệ lễ tân để được kiểm tra gói đang dùng và hỗ trợ nếu đủ điều kiện.',
        N'Membership Management',
        N'đổi gói cao cấp sang cơ bản, đổi gói, downgrade, gói cao cấp, gói cơ bản, chính sách, lễ tân',
        N'Active'
    ),
    (
        N'Tôi muốn nâng cấp từ gói cơ bản lên gói cao cấp được không?',
        N'Việc nâng cấp gói có thể thực hiện tùy theo tình trạng gói hiện tại và chính sách của phòng gym. Bạn vui lòng liên hệ lễ tân để được kiểm tra và hỗ trợ nâng cấp nếu đủ điều kiện.',
        N'Membership Management',
        N'nâng cấp gói, nang cap goi, gói cơ bản lên cao cấp, upgrade, chính sách, lễ tân',
        N'Active'
    ),
    (
        N'Tôi có thể vừa mua gói Gym vừa thuê PT không?',
        N'Có. Bạn có thể sử dụng gói Gym để vào phòng tập và thuê thêm PT nếu muốn được huấn luyện viên cá nhân hướng dẫn bài tập, kỹ thuật và theo dõi tiến độ.',
        N'Membership Package',
        N'vừa mua gói gym vừa thuê pt, gym và pt, thuê PT, huấn luyện viên cá nhân, sử dụng phòng tập',
        N'Active'
    ),
    (
        N'Tôi chưa có gói Gym thì có đăng ký PT được không?',
        N'Bạn nên liên hệ lễ tân để kiểm tra điều kiện đăng ký theo chính sách hiện tại. Thông thường gói Gym dùng để sử dụng phòng tập, còn gói PT là dịch vụ huấn luyện viên cá nhân theo số buổi.',
        N'Personal Trainer',
        N'chưa có gói gym đăng ký PT, đăng ký PT, điều kiện đăng ký PT, gói gym, gói PT, lễ tân',
        N'Active'
    ),
    (
        N'Tôi muốn tập với PT để đá bóng tốt hơn được không?',
        N'Có. Bạn có thể thuê PT để được hướng dẫn bài tập bổ trợ cho bóng đá như chân, core, sức bền, tốc độ và linh hoạt. PT sẽ hỗ trợ điều chỉnh bài tập theo mục tiêu của bạn.',
        N'Training Advice',
        N'PT đá bóng, PT bóng đá, tập với PT để đá bóng tốt hơn, sức mạnh chân, core, tốc độ, linh hoạt',
        N'Active'
    ),
    (
        N'Tôi chỉ muốn tập cardio thì chọn gói nào?',
        N'Nếu bạn chỉ muốn tự tập cardio, có thể chọn gói Gym để sử dụng khu vực tập. Nếu cần lịch cardio theo mục tiêu giảm cân hoặc thể lực, bạn có thể thuê PT để được hướng dẫn.',
        N'Training Advice',
        N'cardio, chỉ tập cardio, tập cardio, thuê PT cardio, giảm cân, thể lực',
        N'Active'
    ),
    (
        N'Tôi muốn tập yoga thì phòng gym có hỗ trợ không?',
        N'Hệ thống có thông tin khu vực hoặc nhu cầu tập yoga trong FAQ. Bạn vui lòng liên hệ lễ tân để kiểm tra lịch lớp, khu vực tập hoặc PT phù hợp nếu muốn được hướng dẫn cụ thể.',
        N'Facilities',
        N'yoga, tập yoga, khu yoga, lớp yoga, lịch yoga, PT yoga, lễ tân',
        N'Active'
    ),
    (
        N'Tôi muốn tập boxing thì chọn PT như thế nào?',
        N'Bạn có thể liên hệ lễ tân hoặc xem hồ sơ PT nếu hệ thống có hiển thị để chọn PT phù hợp với mục tiêu boxing. Nhân viên sẽ hỗ trợ kiểm tra lịch và khả năng sắp xếp PT.',
        N'Training Advice',
        N'boxing, tập boxing, chọn PT boxing, PT phù hợp, hồ sơ PT, lịch PT',
        N'Active'
    ),
    (
        N'Tôi muốn tập để đi thi đấu thì phòng gym có tư vấn không?',
        N'Phòng gym có thể hỗ trợ tư vấn tập luyện ở mức thông tin chung hoặc qua PT. Nếu bạn chuẩn bị thi đấu, nên trao đổi trực tiếp với PT để có lịch tập phù hợp mục tiêu và thể trạng.',
        N'Training Advice',
        N'tập để thi đấu, thi đấu, competition, PT tư vấn, lịch tập, mục tiêu tập luyện',
        N'Active'
    ),
    (
        N'Tôi muốn tập ở nhà thì chatbot có lên lịch tập được không?',
        N'Chatbot chỉ trả lời theo FAQ có sẵn và không tạo lịch tập cá nhân hóa. Nếu bạn cần lịch tập cụ thể, vui lòng liên hệ lễ tân hoặc thuê PT để được tư vấn phù hợp.',
        N'Chat Bot',
        N'tập ở nhà, lịch tập ở nhà, chatbot lên lịch tập, giáo án tập, cá nhân hóa, FAQ, PT tư vấn',
        N'Active'
    ),
    (
        N'Tập gym có giúp ích cho cầu thủ bóng đá không?',
        N'Có. Tập gym đúng cách có thể giúp cầu thủ bóng đá cải thiện sức mạnh, sức bền, tốc độ, core và khả năng hạn chế chấn thương. Người chơi bóng đá nên kết hợp bài tập chân, core, linh hoạt và phục hồi, đồng thời tránh tập quá nặng sát ngày đá bóng.',
        N'Training Advice',
        N'tập gym giúp ích bóng đá, cầu thủ bóng đá, football, soccer, sức mạnh, sức bền, tốc độ, core, chấn thương',
        N'Active'
    ),
    (
        N'Tôi chơi bóng đá thì nên tập gym như thế nào?',
        N'Nếu bạn chơi bóng đá, nên tập gym theo hướng bổ trợ: chân, core, sức bền, linh hoạt và phục hồi. Không nên chỉ tập nặng để tăng cơ, vì lịch tập cần cân bằng với lịch đá bóng. Bạn có thể đăng ký gói gym hoặc thuê PT để được hướng dẫn phù hợp hơn.',
        N'Training Advice',
        N'tôi chơi bóng đá, đá bóng tập gym, lịch tập bóng đá, chân, core, sức bền, linh hoạt',
        N'Active'
    ),
    (
        N'Đá bóng rồi có cần tập chân ở gym nữa không?',
        N'Có thể cần, nhưng nên tập chân đúng cường độ. Bài tập chân trong gym giúp tăng sức mạnh và độ ổn định, còn đá bóng thiên về kỹ năng và sức bền. Bạn nên tránh tập chân quá nặng trước ngày đá bóng để không ảnh hưởng hiệu suất.',
        N'Training Advice',
        N'đá bóng tập chân, tập chân gym, chân, leg day, sức mạnh chân, trước ngày đá bóng',
        N'Active'
    ),
    (
        N'Trước ngày đá bóng có nên tập gym không?',
        N'Bạn nên tránh tập gym quá nặng trước ngày đá bóng, đặc biệt là bài chân cường độ cao. Có thể chọn bài nhẹ, giãn cơ hoặc phục hồi để giữ thể lực. Nếu cần lịch tập cân bằng giữa gym và bóng đá, bạn có thể hỏi PT để được tư vấn.',
        N'Training Advice',
        N'trước ngày đá bóng, tập gym trước trận, tập nhẹ, phục hồi, giãn cơ, leg day',
        N'Active'
    ),
    (
        N'Tập gym có giúp chạy nhanh hơn không?',
        N'Tập gym đúng cách có thể hỗ trợ tốc độ chạy nhờ cải thiện sức mạnh chân, core và khả năng ổn định cơ thể. Tuy nhiên, người tập vẫn cần kết hợp bài chạy, linh hoạt và phục hồi. PT có thể hướng dẫn lịch tập phù hợp với mục tiêu tốc độ.',
        N'Training Advice',
        N'chạy nhanh hơn, tốc độ chạy, speed, sức mạnh chân, core, tập gym tăng tốc độ',
        N'Active'
    ),
    (
        N'Tập gym có giúp bật nhảy cao hơn không?',
        N'Tập gym có thể hỗ trợ bật nhảy nếu tập đúng bài cho chân, core, sức mạnh và độ linh hoạt. Người tập nên kết hợp bài sức mạnh với bài kiểm soát kỹ thuật, không chỉ tập nặng. Nếu bạn cần lộ trình cụ thể, có thể thuê PT để được hướng dẫn.',
        N'Training Advice',
        N'bật nhảy cao, jumping, vertical jump, sức bật, bóng rổ, bóng chuyền, tập chân, core',
        N'Active'
    ),
    (
        N'Người chơi cầu lông có nên tập gym không?',
        N'Có. Người chơi cầu lông có thể tập gym để cải thiện sức mạnh chân, vai, core, tốc độ di chuyển và hạn chế chấn thương. Nên ưu tiên bài bổ trợ, linh hoạt và phục hồi để phù hợp với môn cầu lông.',
        N'Training Advice',
        N'cầu lông, badminton, tập gym cầu lông, vai, core, tốc độ, di chuyển, chấn thương',
        N'Active'
    ),
    (
        N'Người bơi lội có nên tập gym không?',
        N'Có. Người bơi lội có thể tập gym để tăng sức mạnh thân trên, core, độ ổn định vai và sức bền. Nên tập các bài bổ trợ an toàn, không tập quá tải phần vai. Nếu cần lịch tập phù hợp với bơi lội, bạn có thể tham khảo PT.',
        N'Training Advice',
        N'bơi lội, swimming, tập gym bơi lội, vai, core, thân trên, sức bền',
        N'Active'
    ),
    (
        N'Tôi muốn tập 36 buổi thì chọn gói nào?',
        N'Nếu bạn muốn tập 36 buổi với huấn luyện viên cá nhân, bạn nên chọn gói PT Cao cấp 3 Tháng. Gói Gym được tính theo thời hạn sử dụng phòng tập, không phải theo số buổi. Nếu cần xác nhận trước khi đăng ký, vui lòng liên hệ lễ tân.',
        N'Personal Trainer',
        N'tập 36 buổi, chọn gói 36 buổi, gói PT cao cấp, 3 tháng, personal trainer',
        N'Active'
    ),
    (
        N'Tôi muốn tập 12 buổi trong 1 tháng thì chọn gói nào?',
        N'Gói PT Cơ bản 1 Tháng gồm 12 buổi, phù hợp nếu bạn muốn tập với huấn luyện viên cá nhân trong 1 tháng. Nếu bạn chỉ muốn sử dụng phòng tập, hãy chọn gói Gym theo thời hạn.',
        N'Personal Trainer',
        N'12 buổi 1 tháng, gói PT cơ bản, PT 1 tháng, personal trainer, huấn luyện viên cá nhân',
        N'Active'
    ),
    (
        N'Gói Gym có tính theo số buổi không?',
        N'Gói Gym trong hệ thống được quản lý theo thời hạn sử dụng phòng tập, ví dụ 1 tháng hoặc 3 tháng. Số buổi như 12 buổi hoặc 36 buổi thuộc gói PT với huấn luyện viên cá nhân.',
        N'Membership Package',
        N'gói gym tính theo số buổi, gym theo buổi, gym theo tháng, 12 buổi, 36 buổi, gói pt',
        N'Active'
    ),
    (
        N'Gói PT có tính theo tháng hay số buổi?',
        N'Gói PT trong hệ thống có cả thời hạn và số buổi. Gói PT Cơ bản 1 Tháng gồm 12 buổi, còn gói PT Cao cấp 3 Tháng gồm 36 buổi. Bạn nên chọn gói theo nhu cầu tập với huấn luyện viên cá nhân.',
        N'Personal Trainer',
        N'gói PT tính theo tháng hay số buổi, PT theo buổi, PT theo tháng, 12 buổi, 36 buổi',
        N'Active'
    ),
    (
        N'Gói gym cao cấp có phải 36 buổi không?',
        N'Không. Gói Gym Cao cấp 3 Tháng là gói sử dụng phòng tập theo thời hạn 3 tháng. Số buổi 36 thuộc gói PT Cao cấp 3 Tháng, dành cho tập với huấn luyện viên cá nhân.',
        N'General Gym Information',
        N'gym cao cấp 36 buổi, gym cao cấp, 36 buổi, PT cao cấp 3 tháng',
        N'Active'
    ),
    (
        N'Tập hằng ngày trong 1 tháng có được không?',
        N'Với gói Gym Cơ bản 1 Tháng, bạn sử dụng phòng tập trong thời hạn 1 tháng theo quy định của phòng gym. Nếu bạn hỏi về PT, gói PT Cơ bản 1 Tháng gồm 12 buổi, không phải buổi PT mỗi ngày.',
        N'General Gym Information',
        N'1 tháng tập mỗi ngày, tap hang ngay 1 thang, gym 1 tháng, PT 12 buổi, tập hằng ngày',
        N'Active'
    ),
    (
        N'Có thể tập hơn 12 buổi PT trong 1 tháng không?',
        N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Nếu bạn cần số buổi PT nhiều hơn, bạn có thể cân nhắc gói PT Cao cấp 3 Tháng gồm 36 buổi hoặc liên hệ lễ tân để được tư vấn theo nhu cầu.',
        N'Personal Trainer',
        N'hơn 12 buổi PT, PT 1 tháng, PT 12 buổi, PT 36 buổi, gói PT cao cấp',
        N'Active'
    ),
    (
        N'Tập gym trong 3 tháng thì chọn loại nào?',
        N'Nếu bạn muốn sử dụng phòng tập trong 3 tháng, bạn có thể chọn Gói Gym Cao cấp 3 Tháng. Nếu cần tập với huấn luyện viên cá nhân, gói PT Cao cấp 3 Tháng gồm 36 buổi.',
        N'General Gym Information',
        N'tập gym 3 tháng, tap gym 3 thang, gym 3 tháng, loại 3 tháng, PT cao cấp 36 buổi',
        N'Active'
    ),
    (
        N'Tập gym trong 1 tháng thì chọn loại nào?',
        N'Nếu bạn muốn sử dụng phòng tập trong 1 tháng, bạn có thể chọn Gói Gym Cơ bản 1 Tháng. Nếu muốn tập với huấn luyện viên cá nhân trong 1 tháng, gói PT Cơ bản 1 Tháng gồm 12 buổi.',
        N'General Gym Information',
        N'tập gym 1 tháng, tap gym 1 thang, gym cơ bản 1 tháng, PT cơ bản 12 buổi, 1 tháng',
        N'Active'
    ),
    (
        N'Muốn thử tập với chi phí thấp thì chọn gì?',
        N'Bạn có thể bắt đầu với Gói Gym Cơ bản 1 Tháng để làm quen với phòng tập. Chính sách tập thử hoặc ưu đãi có thể thay đổi theo thời điểm, vì vậy bạn nên liên hệ lễ tân để được xác nhận trước khi đăng ký.',
        N'General Gym Information',
        N'gói rẻ nhất, chi phí thấp, thử tập, người mới, gym cơ bản 1 tháng, tập thử',
        N'Active'
    ),
    (
        N'Tôi muốn nhiều buổi PT nhất thì chọn gói nào?',
        N'Trong các gói PT hiện có, gói PT Cao cấp 3 Tháng gồm 36 buổi là gói có nhiều buổi hơn gói PT Cơ bản 1 Tháng gồm 12 buổi. Bạn có thể chọn gói này nếu muốn được PT hỗ trợ dài hơn.',
        N'Personal Trainer',
        N'nhiều buổi PT nhất, PT nhiều buổi, PT 36 buổi, PT cao cấp, huấn luyện viên cá nhân',
        N'Active'
    ),
    (
        N'Tôi muốn tập cùng PT nhưng chưa biết chọn PT nào?',
        N'Bạn có thể liên hệ lễ tân hoặc xem thông tin PT nếu hệ thống hiển thị hồ sơ PT. Nhân viên có thể hỗ trợ bạn chọn PT phù hợp với mục tiêu như giảm cân, tăng cơ, cardio, yoga hoặc boxing.',
        N'General Gym Information',
        N'chọn người hướng dẫn, chọn PT theo mục tiêu, PT phù hợp mục tiêu, giảm cân, tăng cơ, cardio, yoga, boxing',
        N'Active'
    ),
    (
        N'Tôi muốn đổi PT nếu không phù hợp có được không?',
        N'Bạn nên liên hệ lễ tân để kiểm tra tình trạng gói PT và được hỗ trợ đổi PT theo chính sách hiện tại. Việc đổi PT phụ thuộc vào lịch PT, gói đã đăng ký và khả năng sắp xếp của phòng gym.',
        N'Membership Management',
        N'đổi PT, không phù hợp, đổi huấn luyện viên, đổi người hướng dẫn, chính sách PT',
        N'Active'
    ),
    (
        N'Tôi muốn giảm mỡ bụng thì nên chọn gói nào?',
        N'Nếu bạn muốn tự tập để giảm mỡ bụng, có thể bắt đầu với gói Gym. Nếu cần lịch tập, kỹ thuật và theo dõi sát hơn, bạn nên cân nhắc gói PT để được hướng dẫn theo mục tiêu giảm cân.',
        N'Membership Package',
        N'giảm mỡ bụng, giảm cân, chọn gói, gói gym, gói PT, PT giảm cân',
        N'Active'
    ),
    (
        N'Tôi muốn tăng cân tăng cơ thì nên chọn gói nào?',
        N'Nếu bạn muốn tăng cân và tăng cơ, có thể đăng ký gói Gym để tập luyện thường xuyên. Nếu cần hướng dẫn kỹ thuật, lịch tập và theo dõi tiến độ, bạn nên cân nhắc thuê PT.',
        N'Membership Package',
        N'tăng cân tăng cơ, tăng cơ, bulk, chọn gói, gói gym, gói PT, PT tăng cơ',
        N'Active'
    ),
    (
        N'Tôi muốn tập cho đẹp dáng thì nên chọn gym hay PT?',
        N'Nếu bạn đã biết cách tập, gói Gym có thể phù hợp để duy trì luyện tập. Nếu bạn cần lịch tập rõ ràng, chỉnh kỹ thuật và theo dõi mục tiêu vóc dáng, bạn nên cân nhắc thuê PT.',
        N'Membership Package',
        N'đẹp dáng, vóc dáng, body shape, chọn gym hay PT, gói gym, thuê PT',
        N'Active'
    ),
    (
        N'Tôi tập yếu có sợ không theo kịp không?',
        N'Người mới hoặc người có thể lực yếu nên bắt đầu với cường độ vừa phải và tăng dần. Bạn có thể hỏi nhân viên hoặc thuê PT để được hướng dẫn kỹ thuật an toàn, tránh tập quá sức.',
        N'Training Advice',
        N'tập yếu, không theo kịp, người mới, thể lực yếu, tập nhẹ, an toàn tập luyện',
        N'Active'
    ),
    (
        N'Chưa từng tập gym thì có cần người hướng dẫn ban đầu không?',
        N'Bạn không bắt buộc phải thuê PT, nhưng nếu chưa từng tập gym, PT có thể giúp hướng dẫn kỹ thuật, cách dùng máy và lịch tập phù hợp. Bạn cũng có thể bắt đầu với gói Gym Cơ bản 1 Tháng để làm quen.',
        N'Training Advice',
        N'chưa từng tập gym, người mới, người hướng dẫn ban đầu, hướng dẫn kỹ thuật, dùng máy tập, làm quen phòng tập',
        N'Active'
    ),
    (
        N'Chatbot có tư vấn dinh dưỡng chi tiết không?',
        N'Chatbot chỉ trả lời theo FAQ có sẵn và không tư vấn dinh dưỡng cá nhân hóa. Nếu bạn cần tư vấn chi tiết theo thể trạng hoặc mục tiêu, vui lòng liên hệ lễ tân hoặc PT để được hỗ trợ.',
        N'Chat Bot',
        N'chatbot tư vấn dinh dưỡng, dinh dưỡng chi tiết, FAQ, không cá nhân hóa, PT tư vấn',
        N'Active'
    ),
    (
        N'Chatbot có lên giáo án tập cá nhân không?',
        N'Chatbot không tạo giáo án tập cá nhân hóa. Chatbot chỉ tìm câu hỏi trong FAQ và trả lời bằng nội dung có sẵn. Nếu bạn cần giáo án cụ thể, vui lòng liên hệ lễ tân hoặc thuê PT.',
        N'Chat Bot',
        N'chatbot giáo án, lên lịch tập, giáo án cá nhân, cá nhân hóa, FAQ, PT',
        N'Active'
    ),
    (
        N'Chatbot có tư vấn bệnh lý hoặc chấn thương không?',
        N'Chatbot không thay thế tư vấn y tế và không tư vấn bệnh lý cá nhân. Nếu bạn có chấn thương hoặc vấn đề sức khỏe, nên hỏi ý kiến bác sĩ trước khi tập và trao đổi với PT sau khi được phép tập.',
        N'Health Safety',
        N'chatbot bệnh lý, chấn thương, tư vấn y tế, bác sĩ, an toàn tập luyện',
        N'Active'
    ),
    (
        N'Tôi có thể xem thông báo ở đâu?',
        N'Hội viên có thể xem thông báo trong khu vực thông báo của Member Portal sau khi đăng nhập. Nếu bạn không thấy thông báo cần tìm, vui lòng liên hệ nhân viên để được hỗ trợ.',
        N'Member Portal',
        N'xem thông báo, thông báo hội viên, member portal, member notification, đăng nhập, hội viên',
        N'Active'
    ),
    (
        N'Tôi có thể xem thông tin gói tập ở đâu?',
        N'Hội viên có thể xem thông tin gói tập của mình trong Member Portal sau khi đăng nhập. Nếu thông tin chưa đúng hoặc cần hỗ trợ thay đổi gói, vui lòng liên hệ nhân viên hoặc lễ tân.',
        N'Member Portal',
        N'xem thông tin gói tập, gói của tôi, member portal, membership, đăng nhập',
        N'Active'
    ),
    (
        N'Tôi muốn hỏi ngoài FAQ thì phải làm sao?',
        N'Nếu câu hỏi nằm ngoài phạm vi FAQ, chatbot sẽ không tự tạo câu trả lời mới. Bạn vui lòng liên hệ phòng gym qua email hoặc số điện thoại để được hỗ trợ thêm.',
        N'Chat Bot',
        N'hỏi ngoài FAQ, ngoài phạm vi, chatbot không trả lời, email, điện thoại, liên hệ',
        N'Active'
    );

    INSERT INTO dbo.FAQ
    (
        question,
        answer,
        category,
        keywords,
        status
    )
    SELECT
        faq.question,
        faq.answer,
        faq.category,
        faq.keywords,
        faq.status
    FROM @ContextualFAQAdditions faq
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM dbo.FAQ existing
        WHERE existing.question = faq.question
    );
END;
GO
