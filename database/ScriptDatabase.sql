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

INSERT [dbo].[GymPackages] ([PackageID], [PackageName], [DurationMonths], [Price], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, N'Gói Gym 1 Tháng', 1, CAST(300000.00 AS Decimal(12, 2)), N'Gói tập gym tiêu chuẩn trong 1 tháng.', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4753462' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[GymPackages] ([PackageID], [PackageName], [DurationMonths], [Price], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, N'Gói Gym 3 Tháng', 3, CAST(800000.00 AS Decimal(12, 2)), N'Gói tập gym tiêu chuẩn trong 3 tháng.', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4753462' AS DateTime2), NULL, NULL, 0)
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

INSERT [dbo].[MemberPackages] ([MemberPackageID], [MemberID], [PackageID], [StartDate], [EndDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 1, 1, CAST(N'2026-05-01' AS Date), CAST(N'2026-06-01' AS Date), N'Expired', N'System', CAST(N'2026-05-31T18:27:47.4782421' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[MemberPackages] ([MemberPackageID], [MemberID], [PackageID], [StartDate], [EndDate], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 6, 1, CAST(N'2026-07-08' AS Date), CAST(N'2026-08-08' AS Date), N'Active', N'StaffUserID: 2', CAST(N'2026-07-08T10:49:36.7660909' AS DateTime2), N'StaffUserID: 2', CAST(N'2026-07-08T10:49:40.6811133' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[MemberPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 4, N'Nam', CAST(N'2000-01-01' AS Date), N'Hà Nội', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4538048' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (5, 25, N'Nam', CAST(N'2004-10-22' AS Date), N'Hoài Đức - Hà Nội', N'Pending', N'System', CAST(N'2026-06-25T10:03:26.5753400' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (6, 27, N'Nữ', CAST(N'2001-06-14' AS Date), N'Hoàn Kiếm-Hà Nội', N'Pending', N'System', CAST(N'2026-06-30T10:37:39.6844516' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (7, 28, N'Nam', CAST(N'2002-05-12' AS Date), N'Cầu Giấy - Hà Nội', N'Active', N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (8, 29, N'Nữ', CAST(N'2003-08-20' AS Date), N'Thanh Xuân - Hà Nội', N'Active', N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (9, 30, N'Nam', CAST(N'2001-11-15' AS Date), N'Đống Đa - Hà Nội', N'Active', N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (10, 31, N'Nữ', CAST(N'2004-02-28' AS Date), N'Ba Đình - Hà Nội', N'Active', N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Members] ([MemberID], [UserID], [Gender], [DateOfBirth], [Address], [MembershipStatus], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (11, 32, N'Nam', CAST(N'2000-09-10' AS Date), N'Hai Bà Trưng - Hà Nội', N'Active', N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
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
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (9, 13, N'Yoga', N'Chuyên hướng dẫn Yoga & Linh hoạt, hỗ trợ học viên cải thiện độ dẻo dai, tư thế, thăng bằng và kiểm soát hơi thở. Phù hợp cho người mới bắt đầu hoặc người muốn tập luyện nhẹ nhàng, an toàn và đều đặn.', N'Active', N'Demo Admin', CAST(N'2026-06-09T11:56:50.6200000' AS DateTime2), N'admin@gym.com', CAST(N'2026-06-26T02:35:17.4100000' AS DateTime2), 0, CAST(N'2024-02-15' AS Date), N'Nguyen_Thi_Nga_Yoga_cer', N'assets/uploads/pt-certificate/Nguyen_Thi_Nga_Yoga_cer.png', N'Nguyễn Thị Nga', N'Nga Yoga', N'assets/uploads/pt-avatar/Nguyen_Thi_Nga_Yoga.jpg')
INSERT [dbo].[PersonalTrainers] ([PTID], [UserID], [Specialization], [Description], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [CareerStartDate], [CertificateFileName], [CertificateFilePath], [FullName], [DisplayName], [AvatarPath]) VALUES (16, 22, N'Phục hồi thể lực', N'Tự tin là 1 PT giỏi trong lĩnh vực phục hồi thể lực! 
Sẽ giúp bạn có giây phút healing sau buổi tập căng thẳng. Chúc các bạn sớm có người yêu', N'Active', N'Demo Admin', CAST(N'2026-06-14T00:01:55.0133333' AS DateTime2), N'coachviet_phtl@gmail.com', CAST(N'2026-06-26T02:31:59.5466667' AS DateTime2), 0, CAST(N'2026-06-20' AS Date), N'Tran_Quoc_Viet.png', N'assets/uploads/pt-certificate/Tran_Quoc_Viet.png', N'Trần Quốc Việt', N'Coach Việt', N'assets/uploads/pt-avatar/Coach_Viet_Update.jpg')
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
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (3, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Completed', N'Tôi muốn giảm cân, hãy xếp lịch tập sớm cho tôi', N'System', CAST(N'2026-06-02T04:38:48.7290377' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (4, 1, 3, CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02' AS Date), CAST(N'2026-07-02' AS Date), N'Completed', N'Tôi thực sự muốn giảm cân. Bạn bè bảo tôi quá béo, tôi rất tự ti.', N'System', CAST(N'2026-06-02T04:39:23.1548789' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (5, 1, 7, CAST(N'2026-06-10' AS Date), CAST(N'2026-06-10' AS Date), CAST(N'2026-07-09' AS Date), N'Completed', N'', N'Demo Member', CAST(N'2026-06-07T09:42:34.2420419' AS DateTime2), NULL, NULL, 0, CAST(1100000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (6, 1, 11, CAST(N'2026-06-15' AS Date), CAST(N'2026-06-15' AS Date), CAST(N'2026-07-14' AS Date), N'Completed', N'', N'Demo Member', CAST(N'2026-06-14T00:08:42.3140381' AS DateTime2), NULL, NULL, 0, CAST(1350000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (7, 1, 8, CAST(N'2026-06-26' AS Date), CAST(N'2026-06-26' AS Date), CAST(N'2026-09-25' AS Date), N'Active', N'', N'Demo Member', CAST(N'2026-06-24T15:23:02.6051048' AS DateTime2), NULL, NULL, 0, CAST(2970000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 36)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (8, 5, 4, CAST(N'2026-07-01' AS Date), NULL, NULL, N'Cancelled', N'Khởi đầu tháng mới tôi muốn tập giữ cân nặng của tôi cho tới tháng 12 để đi đi thi boxing mức cân 60kg. | Lý do hủy: PT quá bận', N'Nguyễn Đình Phú', CAST(N'2026-06-25T10:16:40.4264412' AS DateTime2), N'Demo Staff', CAST(N'2026-06-26T02:46:08.4461538' AS DateTime2), 0, CAST(3240000.00 AS Decimal(12, 2)), N'Cancelled', 2, CAST(N'2026-06-26T02:46:08.4461538' AS DateTime2), 36)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (9, 5, 12, CAST(N'2026-07-01' AS Date), CAST(N'2026-07-01' AS Date), CAST(N'2026-09-30' AS Date), N'Cancelled', N'Tôi muốn tập boxing ca sáng
 | Lý do hủy: PT bận vkl', N'Nguyễn Đình Phú', CAST(N'2026-06-25T12:15:14.4783089' AS DateTime2), N'Demo Admin', CAST(N'2026-06-25T12:15:56.9338719' AS DateTime2), 0, CAST(3645000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-25T12:15:56.9338719' AS DateTime2), 36)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (10, 1, 7, CAST(N'2026-06-25' AS Date), CAST(N'2026-06-25' AS Date), CAST(N'2026-07-24' AS Date), N'Completed', N'', N'Demo Member', CAST(N'2026-06-25T23:47:33.3218669' AS DateTime2), NULL, NULL, 0, CAST(1100000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (11, 1, 17, CAST(N'2026-06-30' AS Date), CAST(N'2026-06-30' AS Date), CAST(N'2026-07-29' AS Date), N'Cancelled', N'Tôi muốn tập thử yoga! | Lý do hủy: Thành viên đăng ký quá nhiều lớp!', N'Demo Member', CAST(N'2026-06-30T10:34:30.1131562' AS DateTime2), N'Demo Admin', CAST(N'2026-06-30T10:35:13.7616447' AS DateTime2), 0, CAST(1500000.00 AS Decimal(12, 2)), N'Cancelled', 1, CAST(N'2026-06-30T10:35:13.7616447' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (12, 6, 17, CAST(N'2026-06-30' AS Date), CAST(N'2026-06-30' AS Date), CAST(N'2026-07-29' AS Date), N'Active', N'Tôi muốn tập yoga để có dánhg đẹp', N'Trần Hà Linh', CAST(N'2026-06-30T10:42:08.4337287' AS DateTime2), NULL, NULL, 0, CAST(1500000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (13, 6, 5, CAST(N'2026-06-30' AS Date), CAST(N'2026-06-30' AS Date), CAST(N'2026-07-29' AS Date), N'Active', N'', N'Trần Hà Linh', CAST(N'2026-06-30T10:56:53.4668020' AS DateTime2), NULL, NULL, 0, CAST(1400000.00 AS Decimal(12, 2)), N'Paid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (14, 6, 13, CAST(N'2026-07-01' AS Date), CAST(N'2026-07-01' AS Date), CAST(N'2026-07-31' AS Date), N'Active', N'Tôi muốn đầu tư thêm cả vào khoản dinh dưỡng sau các buổi tập nữa', N'Trần Hà Linh', CAST(N'2026-07-01T15:15:46.8719952' AS DateTime2), N'Demo Admin', CAST(N'2026-07-07T22:51:06.6869893' AS DateTime2), 0, CAST(999000.00 AS Decimal(12, 2)), N'Paid', 1, CAST(N'2026-07-07T22:51:06.6869893' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (15, 6, 13, CAST(N'2026-07-07' AS Date), CAST(N'2026-07-07' AS Date), CAST(N'2026-08-06' AS Date), N'Active', N'', N'Trần Hà Linh', CAST(N'2026-07-07T23:12:32.2196714' AS DateTime2), N'Demo Staff', CAST(N'2026-07-07T23:13:05.3611825' AS DateTime2), 0, CAST(999000.00 AS Decimal(12, 2)), N'Paid', 2, CAST(N'2026-07-07T23:13:05.3611825' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (16, 5, 5, CAST(N'2026-07-09' AS Date), CAST(N'2026-07-09' AS Date), CAST(N'2026-08-04' AS Date), N'Active', N'', N'Nguyễn Đình Phú', CAST(N'2026-07-08T00:17:08.1787968' AS DateTime2), N'Demo Admin', CAST(N'2026-07-08T00:19:17.6347677' AS DateTime2), 0, CAST(1400000.00 AS Decimal(12, 2)), N'Paid', 1, CAST(N'2026-07-08T00:19:17.6347677' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (17, 6, 19, CAST(N'2026-07-08' AS Date), CAST(N'2026-07-08' AS Date), CAST(N'2026-08-07' AS Date), N'Active', N'Tôi muốn phục hồi thể lực sau 1 ngày đi làm mệt mỏi
', N'Trần Hà Linh', CAST(N'2026-07-08T10:50:20.7435352' AS DateTime2), N'Demo Staff', CAST(N'2026-07-08T10:51:23.1842751' AS DateTime2), 0, CAST(400000.00 AS Decimal(12, 2)), N'Paid', 2, CAST(N'2026-07-08T10:51:23.1842751' AS DateTime2), 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (18, 1, 1, CAST(N'2026-07-28' AS Date), NULL, NULL, N'Pending', N'Đăng ký tập luyện giữ dáng', N'Member', CAST(N'2026-07-27T10:00:00' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (19, 6, 3, CAST(N'2026-07-29' AS Date), NULL, NULL, N'Pending', N'Muốn cải thiện thể lực và sức bền', N'Member', CAST(N'2026-07-27T11:00:00' AS DateTime2), NULL, NULL, 0, CAST(1200000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (20, 5, 7, CAST(N'2026-07-30' AS Date), NULL, NULL, N'Pending', N'Cần giảm cân và săn chắc cơ bắp', N'Member', CAST(N'2026-07-27T12:00:00' AS DateTime2), NULL, NULL, 0, CAST(1100000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (21, 1, 11, CAST(N'2026-07-31' AS Date), NULL, NULL, N'Pending', N'Đăng ký khóa boxing nâng cao thể lực', N'Member', CAST(N'2026-07-27T13:00:00' AS DateTime2), NULL, NULL, 0, CAST(1350000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (22, 6, 13, CAST(N'2026-08-01' AS Date), NULL, NULL, N'Pending', N'Tập yoga bay để cải thiện xương khớp', N'Member', CAST(N'2026-07-27T14:00:00' AS DateTime2), NULL, NULL, 0, CAST(999000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (23, 5, 17, CAST(N'2026-08-02' AS Date), NULL, NULL, N'Pending', N'Tư vấn dinh dưỡng và huấn luyện phục hồi thể lực', N'Member', CAST(N'2026-07-27T15:00:00' AS DateTime2), NULL, NULL, 0, CAST(1500000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (24, 1, 5, CAST(N'2026-08-03' AS Date), NULL, NULL, N'Pending', N'Khóa tập tăng cơ bắp chuyên sâu', N'Member', CAST(N'2026-07-27T16:00:00' AS DateTime2), NULL, NULL, 0, CAST(1400000.00 AS Decimal(12, 2)), N'Unpaid', NULL, NULL, 12)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (25, 7, 6, CAST(N'2026-06-15' AS Date), CAST(N'2026-06-15' AS Date), CAST(N'2026-09-15' AS Date), N'Active', N'Huấn luyện nâng cao thể lực', N'Member', CAST(N'2026-06-14T10:00:00' AS DateTime2), N'Admin', CAST(N'2026-06-14T10:05:00' AS DateTime2), 0, CAST(3780000.00 AS Decimal(12, 2)), N'Paid', 1, CAST(N'2026-06-14T10:05:00' AS DateTime2), 36)
INSERT [dbo].[PTRegistrations] ([PTRegistrationID], [MemberID], [PTServicePriceID], [PreferredStartDate], [StartDate], [EndDate], [Status], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [TotalAmount], [PaymentStatus], [ProcessedByUserID], [ProcessedAt], [PurchasedSessions]) VALUES (26, 8, 8, CAST(N'2026-06-15' AS Date), CAST(N'2026-06-15' AS Date), CAST(N'2026-09-15' AS Date), N'Active', N'Cần cải thiện sức bền tim mạch', N'Member', CAST(N'2026-06-14T10:00:00' AS DateTime2), N'Admin', CAST(N'2026-06-14T10:05:00' AS DateTime2), 0, CAST(2970000.00 AS Decimal(12, 2)), N'Paid', 1, CAST(N'2026-06-14T10:05:00' AS DateTime2), 36)
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
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (88, 3, 2, 1, CAST(N'2026-07-02' AS Date), CAST(N'08:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Cancelled', N'Pending', 1, N'Hội viên trùng lịch học cá nhân', NULL, CAST(N'2026-06-24T22:21:46.0500000' AS DateTime2), N'Demo Admin', CAST(N'2026-07-01T23:55:42.5600000' AS DateTime2), 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
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
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (133, 3, 3, 1, CAST(N'2026-07-28' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (134, 5, 4, 1, CAST(N'2026-07-28' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (135, 6, 6, 1, CAST(N'2026-07-28' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (136, 12, 9, 6, CAST(N'2026-07-28' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (137, 14, 7, 6, CAST(N'2026-07-28' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (138, 3, 3, 1, CAST(N'2026-07-28' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (139, 5, 4, 1, CAST(N'2026-07-28' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (140, 6, 6, 1, CAST(N'2026-07-28' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (141, 12, 9, 6, CAST(N'2026-07-28' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (142, 14, 7, 6, CAST(N'2026-07-28' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-07-27T21:00:00.000' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (134, 25, 3, 7, CAST(N'2026-06-15' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (135, 25, 3, 7, CAST(N'2026-06-17' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (136, 25, 3, 7, CAST(N'2026-06-19' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (137, 25, 3, 7, CAST(N'2026-06-22' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (138, 25, 3, 7, CAST(N'2026-06-24' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (139, 25, 3, 7, CAST(N'2026-06-26' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (140, 25, 3, 7, CAST(N'2026-06-29' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (141, 25, 3, 7, CAST(N'2026-07-01' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (142, 25, 3, 7, CAST(N'2026-07-03' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (143, 25, 3, 7, CAST(N'2026-07-06' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (144, 25, 3, 7, CAST(N'2026-07-08' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (145, 25, 3, 7, CAST(N'2026-07-10' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (146, 25, 3, 7, CAST(N'2026-07-13' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (147, 25, 3, 7, CAST(N'2026-07-15' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (148, 25, 3, 7, CAST(N'2026-07-17' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (149, 25, 3, 7, CAST(N'2026-07-20' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (150, 25, 3, 7, CAST(N'2026-07-22' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (151, 25, 3, 7, CAST(N'2026-07-24' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (152, 25, 3, 7, CAST(N'2026-07-27' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (153, 25, 3, 7, CAST(N'2026-07-29' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (154, 25, 3, 7, CAST(N'2026-07-31' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (155, 25, 3, 7, CAST(N'2026-08-03' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (156, 25, 3, 7, CAST(N'2026-08-05' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (157, 25, 3, 7, CAST(N'2026-08-07' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (158, 25, 3, 7, CAST(N'2026-08-10' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (159, 25, 3, 7, CAST(N'2026-08-12' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (160, 25, 3, 7, CAST(N'2026-08-14' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (161, 25, 3, 7, CAST(N'2026-08-17' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (162, 25, 3, 7, CAST(N'2026-08-19' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (163, 25, 3, 7, CAST(N'2026-08-21' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (164, 25, 3, 7, CAST(N'2026-08-24' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (165, 25, 3, 7, CAST(N'2026-08-26' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (166, 25, 3, 7, CAST(N'2026-08-28' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (167, 25, 3, 7, CAST(N'2026-08-31' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (168, 25, 3, 7, CAST(N'2026-09-02' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (169, 25, 3, 7, CAST(N'2026-09-04' AS Date), CAST(N'08:15:00' AS Time), CAST(N'09:45:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (170, 26, 4, 8, CAST(N'2026-06-15' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (171, 26, 4, 8, CAST(N'2026-06-17' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (172, 26, 4, 8, CAST(N'2026-06-19' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (173, 26, 4, 8, CAST(N'2026-06-22' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (174, 26, 4, 8, CAST(N'2026-06-24' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (175, 26, 4, 8, CAST(N'2026-06-26' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (176, 26, 4, 8, CAST(N'2026-06-29' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (177, 26, 4, 8, CAST(N'2026-07-01' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (178, 26, 4, 8, CAST(N'2026-07-03' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (179, 26, 4, 8, CAST(N'2026-07-06' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (180, 26, 4, 8, CAST(N'2026-07-08' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (181, 26, 4, 8, CAST(N'2026-07-10' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (182, 26, 4, 8, CAST(N'2026-07-13' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (183, 26, 4, 8, CAST(N'2026-07-15' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (184, 26, 4, 8, CAST(N'2026-07-17' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (185, 26, 4, 8, CAST(N'2026-07-20' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (186, 26, 4, 8, CAST(N'2026-07-22' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (187, 26, 4, 8, CAST(N'2026-07-24' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (188, 26, 4, 8, CAST(N'2026-07-27' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Completed', N'Attended', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (189, 26, 4, 8, CAST(N'2026-07-29' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (190, 26, 4, 8, CAST(N'2026-07-31' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (191, 26, 4, 8, CAST(N'2026-08-03' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (192, 26, 4, 8, CAST(N'2026-08-05' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (193, 26, 4, 8, CAST(N'2026-08-07' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (194, 26, 4, 8, CAST(N'2026-08-10' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (195, 26, 4, 8, CAST(N'2026-08-12' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (196, 26, 4, 8, CAST(N'2026-08-14' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (197, 26, 4, 8, CAST(N'2026-08-17' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (198, 26, 4, 8, CAST(N'2026-08-19' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (199, 26, 4, 8, CAST(N'2026-08-21' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (200, 26, 4, 8, CAST(N'2026-08-24' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (201, 26, 4, 8, CAST(N'2026-08-26' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (202, 26, 4, 8, CAST(N'2026-08-28' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (203, 26, 4, 8, CAST(N'2026-08-31' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (204, 26, 4, 8, CAST(N'2026-09-02' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PTSchedules] ([PTScheduleID], [PTRegistrationID], [PTID], [MemberID], [SessionDate], [StartTime], [EndTime], [SessionStatus], [PTAttendanceResult], [CreatedByUserID], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted], [OriginalPTID], [SubstituteReason], [SubstituteByUserID], [SubstituteAt], [CancelledByUserID], [CancelledAt], [CancellationReason]) VALUES (205, 26, 4, 8, CAST(N'2026-09-04' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Upcoming', N'Pending', 1, NULL, NULL, CAST(N'2026-06-14T10:00:00' AS DateTime2), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
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
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (17, 9, 1, CAST(1500000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T02:33:34.0800000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (18, 9, 2, CAST(4200000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-06-26T02:33:34.0833333' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (19, 16, 1, CAST(400000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-07-01T19:34:18.1100000' AS DateTime2), N'System', CAST(N'2026-07-08T10:48:25.4633333' AS DateTime2), 0)
INSERT [dbo].[PTServicePrices] ([PTServicePriceID], [PTID], [PTPackageTypeID], [Price], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (20, 16, 2, CAST(1100000.00 AS Decimal(12, 2)), N'Active', N'System', CAST(N'2026-07-01T19:34:18.1133333' AS DateTime2), N'System', CAST(N'2026-07-08T10:48:25.4633333' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[PTServicePrices] OFF
GO
SET IDENTITY_INSERT [dbo].[RescheduleRequests] ON 

INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (1, 103, 7, 4, CAST(N'2026-07-09' AS Date), CAST(N'18:00:00' AS Time), CAST(N'19:30:00' AS Time), CAST(N'2026-07-11' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), N'Approved', N'Trùng lịch học cá nhân', NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-07-08T10:04:31.3879089' AS DateTime2), CAST(N'2026-07-08T13:02:07.9833640' AS DateTime2))
INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (3, 124, 6, 27, CAST(N'2026-07-10' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), CAST(N'2026-07-09' AS Date), CAST(N'15:15:00' AS Time), CAST(N'16:45:00' AS Time), N'Rejected', N'Huấn luyện viên bận lịch đào tạo đột xuất', NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-07-08T13:16:02.9716566' AS DateTime2), CAST(N'2026-07-08T13:16:31.9243121' AS DateTime2))
INSERT [dbo].[RescheduleRequests] ([RequestID], [PTScheduleID], [SenderUserID], [ReceiverUserID], [OriginalDate], [OriginalStartTime], [OriginalEndTime], [ProposedDate], [ProposedStartTime], [ProposedEndTime], [Status], [Reason], [ResponseReason], [RespondedByUserID], [RespondedAt], [EscalatedByUserID], [EscalatedAt], [EscalationReason], [CreatedDate], [UpdatedDate]) VALUES (4, 112, 27, 13, CAST(N'2026-07-10' AS Date), CAST(N'18:45:00' AS Time), CAST(N'20:15:00' AS Time), CAST(N'2026-07-11' AS Date), CAST(N'10:00:00' AS Time), CAST(N'11:30:00' AS Time), N'Approved', N'Thành viên có việc gia đình đột xuất', NULL, 13, CAST(N'2026-07-08T13:21:33.0399056' AS DateTime2), NULL, NULL, NULL, CAST(N'2026-07-08T13:20:49.6322291' AS DateTime2), CAST(N'2026-07-08T13:21:33.0399056' AS DateTime2))
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
INSERT [dbo].[StaffPTAttendance] ([AttendanceID], [UserID], [UserRole], [CheckedInAt], [CheckedOutAt], [ShiftBlock], [Status], [CheckedBy], [Note], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (2, 5, N'PT', CAST(N'2026-06-30T10:27:16.0472539' AS DateTime2), NULL, N'Morning', N'Active', 2, NULL, N'Demo Staff', CAST(N'2026-06-30T10:27:16.0472539' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[StaffPTAttendance] OFF
GO
SET IDENTITY_INSERT [dbo].[Staffs] ON 

INSERT [dbo].[Staffs] ([StaffID], [UserID], [Position], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (1, 2, N'Receptionist', N'Active', N'System', CAST(N'2026-05-31T18:27:47.4559441' AS DateTime2), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Staffs] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Tokens] ON 

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
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (13, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (22, 3)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (4, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (25, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (27, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (28, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (29, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (30, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (31, 4)
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (32, 4)
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
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (13, N'ngayogapt@gmai.com', N'85cfa7fff0e70a6417033db10ce37cb7b608ec140e25960f67813b16e17a0556', N'Nga Yoga', N'0987986435', N'Active', 0, N'Demo Admin', CAST(N'2026-06-09T11:56:50.5990000' AS DateTime2), NULL, CAST(N'2026-06-30T10:54:13.6800167' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (22, N'coachviet_phtl@gmail.com', N'00650ae6b819d1af2d2db529cb693428f4e2175bb746b143718d15d29495ae9c', N'Trần Quốc Việt', N'0124579641', N'Active', 0, N'Demo Admin', CAST(N'2026-06-14T00:01:54.9910000' AS DateTime2), NULL, CAST(N'2026-06-18T17:58:16.0548873' AS DateTime2), 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (25, N'phundhe181315@fpt.edu.vn', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Nguyễn Đình Phú', N'0102030908', N'Active', 0, N'System', CAST(N'2026-06-25T10:03:26.5569284' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (27, N'member.halinh@gmail.com', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Trần Hà Linh', N'0354123965', N'Active', 0, N'System', CAST(N'2026-06-30T10:37:39.6801440' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (28, N'member.huy@gmail.com', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Nguyễn Đức Huy', N'0354123966', N'Active', 0, N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (29, N'member.phuong@gmail.com', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Trần Thu Phương', N'0354123967', N'Active', 0, N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (30, N'member.tuan@gmail.com', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Lê Anh Tuấn', N'0354123968', N'Active', 0, N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (31, N'member.linh@gmail.com', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Phạm Khánh Linh', N'0354123969', N'Active', 0, N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Email], [PasswordHash], [DisplayName], [Phone], [Status], [MustChangePassword], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [IsDeleted]) VALUES (32, N'member.hoang@gmail.com', N'5600376e863d2f57a053518f324ad3840b0bc2348b573af281a7b7cbe7a228c6', N'Hoàng Văn Nam', N'0354123970', N'Active', 0, N'System', CAST(N'2026-07-27T21:40:00' AS DateTime2), NULL, NULL, 0)
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
GO
GO
GO
GO
GO
GO
GO
GO
ALTER TABLE [dbo].[User_Tokens] CHECK CONSTRAINT [FK_UserTokens_Users]
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users]
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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ARITHABORT ON
GO
SET NUMERIC_ROUNDABORT OFF
GO

USE [GymCenterManagement]
GO

DECLARE @DemoNote nvarchar(500) = N'DEMO_ATTENDANCE_2026_07_01_TO_26';
DECLARE @StartDate date = CAST(N'2026-07-01' AS date);
DECLARE @EndDate date = CAST(N'2026-07-26' AS date);

;WITH DemoUsers AS
(
    SELECT v.UserID, v.UserRole, v.UserOffset
    FROM (VALUES
        (2, N'Staff', 0),
        (3, N'PT',    1),
        (5, N'PT',    2)
    ) v(UserID, UserRole, UserOffset)
    INNER JOIN dbo.Users u
        ON u.UserID = v.UserID
       AND u.IsDeleted = 0
),
DemoDates AS
(
    SELECT @StartDate AS WorkDate
    UNION ALL
    SELECT DATEADD(DAY, 1, WorkDate)
    FROM DemoDates
    WHERE WorkDate < @EndDate
),
DemoShifts AS
(
    SELECT *
    FROM (VALUES
        (N'Morning',   8 * 60,       12 * 60,      0),
        (N'Afternoon', 13 * 60 + 15, 16 * 60 + 45, 1),
        (N'Evening',   17 * 60,      20 * 60 + 30, 2)
    ) v(ShiftBlock, ShiftStartMinute, ShiftEndMinute, ShiftOffset)
),
DemoRows AS
(
    SELECT
        u.UserID,
        u.UserRole,
        d.WorkDate,
        s.ShiftBlock,
        s.ShiftStartMinute,
        s.ShiftEndMinute,
        (DATEDIFF(DAY, @StartDate, d.WorkDate) + u.UserOffset + (s.ShiftOffset * 2)) % 6 AS DemoPattern
    FROM DemoDates d
    CROSS JOIN DemoShifts s
    CROSS JOIN DemoUsers u
)
INSERT INTO dbo.StaffPTAttendance
    (UserID, UserRole, CheckedInAt, CheckedOutAt, ShiftBlock,
     Status, CheckedBy, Note, CreatedBy, CreatedDate,
     UpdatedBy, UpdatedDate, IsDeleted)
SELECT
    r.UserID,
    r.UserRole,
    DATEADD(MINUTE,
        r.ShiftStartMinute
        + CASE r.DemoPattern
            WHEN 1 THEN 10
            WHEN 3 THEN 10
            ELSE 2
          END,
        CAST(r.WorkDate AS datetime2)),
    CASE
        WHEN r.DemoPattern = 4 THEN NULL
        ELSE DATEADD(MINUTE,
            r.ShiftEndMinute
            + CASE r.DemoPattern
                WHEN 2 THEN -20
                WHEN 3 THEN -20
                ELSE 5
              END,
            CAST(r.WorkDate AS datetime2))
    END,
    r.ShiftBlock,
    N'Active',
    1,
    @DemoNote,
    N'Demo Admin',
    DATEADD(MINUTE,
        r.ShiftStartMinute
        + CASE r.DemoPattern
            WHEN 1 THEN 10
            WHEN 3 THEN 10
            ELSE 2
          END,
        CAST(r.WorkDate AS datetime2)),
    CASE WHEN r.DemoPattern = 4 THEN NULL ELSE N'1' END,
    CASE
        WHEN r.DemoPattern = 4 THEN NULL
        ELSE DATEADD(MINUTE,
            r.ShiftEndMinute
            + CASE r.DemoPattern
                WHEN 2 THEN -20
                WHEN 3 THEN -20
                ELSE 5
              END,
            CAST(r.WorkDate AS datetime2))
    END,
    0
FROM DemoRows r
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.StaffPTAttendance existing
    WHERE existing.UserID = r.UserID
      AND existing.UserRole = r.UserRole
      AND existing.AttendanceDate = r.WorkDate
      AND existing.ShiftBlock = r.ShiftBlock
      AND existing.IsDeleted = 0
)
OPTION (MAXRECURSION 100);
GO

SELECT
    UserID,
    UserRole,
    COUNT(*) AS DemoRecords,
    MIN(AttendanceDate) AS FromDate,
    MAX(AttendanceDate) AS ToDate
FROM dbo.StaffPTAttendance
WHERE Note = N'DEMO_ATTENDANCE_2026_07_01_TO_26'
GROUP BY UserID, UserRole
ORDER BY UserRole, UserID;
GO

-- Reset FAQ data to the approved selectable FAQ set.
IF OBJECT_ID(N'dbo.FAQ', N'U') IS NOT NULL
BEGIN
    DELETE FROM dbo.FAQ;
    DBCC CHECKIDENT (N'dbo.FAQ', RESEED, 0);
    SET IDENTITY_INSERT dbo.FAQ ON;

    INSERT INTO dbo.FAQ (faq_id, question, answer, category, keywords, status)
    VALUES
    (1, N'Địa chỉ phòng gym?', N'Địa chỉ phòng gym: QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội', N'Thông tin phòng gym', N'địa chỉ, dia chi, phòng gym, phong gym, hòa lạc, hoa lac, hà nội, ha noi', N'Active'),
    (2, N'Thông tin liên hệ?', N'Thông tin liên hệ: 0987654321, support@gcms.com', N'Thông tin phòng gym', N'liên hệ, lien he, hotline, số điện thoại, so dien thoai, email, support', N'Active'),
    (3, N'Thời gian mở cửa?', N'Thời gian mở cửa: 8:00-20:30 tất cả các ngày trong tuần', N'Thông tin phòng gym', N'thời gian mở cửa, thoi gian mo cua, giờ mở cửa, gio mo cua, lịch mở cửa, lich mo cua', N'Active'),
    (4, N'Làm sao để đăng ký hội viên?', N'Bạn có thể ra quầy lễ tân để được hỗ trợ hoặc đăng ký qua mục đăng ký thành viên trên website', N'Hội viên', N'đăng ký hội viên, dang ky hoi vien, thành viên, thanh vien, lễ tân, le tan, website', N'Active'),
    (5, N'Đăng ký cần những thông tin gì?', N'Khi đăng ký hội viên bạn cần những thông tin như sau họ tên, email, số điện thoại, mật khẩu.', N'Hội viên', N'thông tin đăng ký, thong tin dang ky, họ tên, ho ten, email, số điện thoại, so dien thoai, mật khẩu, mat khau', N'Active'),
    (6, N'Chỉnh sửa thông tin cá nhân như thế nào?', N'Bạn có thể đăng nhập vào tài khoản cá nhân của mình và chỉnh sửa thông tin cá nhân của mình', N'Hội viên', N'chỉnh sửa thông tin, chinh sua thong tin, thông tin cá nhân, thong tin ca nhan, tài khoản, tai khoan', N'Active'),
    (7, N'Quên mật khẩu thì phải làm sao?', N'Bạn có thể ra quầy lễ tân để được hỗ trợ hoặc đổi mật khẩu qua website', N'Hội viên', N'quên mật khẩu, quen mat khau, đổi mật khẩu, doi mat khau, lễ tân, le tan, website', N'Active'),
    (8, N'Đăng ký gói tập như thế nào?', N'Bạn có thể ra quầy lễ tân để được hỗ trợ hoặc thao tác trực tiếp qua website', N'Gói tập', N'đăng ký gói tập, dang ky goi tap, mua gói tập, mua goi tap, lễ tân, le tan, website', N'Active'),
    (9, N'Có những gói tập nào?', N'Bạn có thể xem chi tiết các gói tập trên hệ thống', N'Gói tập', N'gói tập, goi tap, danh sách gói, danh sach goi, chi tiết gói, chi tiet goi', N'Active'),
    (10, N'Có gói tập kèm PT không?', N'Có. Bạn có thể xem chi tiết các gói tập với PT trên hệ thống', N'Gói tập', N'gói tập kèm PT, goi tap kem PT, huấn luyện viên, huan luyen vien, personal trainer', N'Active'),
    (11, N'Làm sao để gia hạn gói tập?', N'Bạn có thể ra quầy lễ tân để được hỗ trợ gia hạn gói tập hoặc đăng ký gói tập mới.', N'Gói tập', N'gia hạn gói tập, gia han goi tap, đăng ký gói mới, dang ky goi moi, lễ tân, le tan', N'Active'),
    (12, N'Có thể chuyển giao gói tập không?', N'Có thể. Tuy nhiên bạn cần ra quầy lễ tân để kiểm tra thông tin gói tập và chuyển giao', N'Gói tập', N'chuyển giao gói tập, chuyen giao goi tap, chuyển nhượng, chuyen nhuong, lễ tân, le tan', N'Active'),
    (13, N'Có thể thanh toán bằng những hình thức nào?', N'Có thể thanh toán bằng phương thức chuyển khoản và tiền mặt.', N'Thủ tục thanh toán', N'thanh toán, thanh toan, hình thức thanh toán, hinh thuc thanh toan, chuyển khoản, chuyen khoan, tiền mặt, tien mat', N'Active'),
    (14, N'Có thể thanh toán ở đâu?', N'Có thể thanh toán trực tiếp tại quầy lễ tân hoặc trên website', N'Thủ tục thanh toán', N'thanh toán ở đâu, thanh toan o dau, quầy lễ tân, quay le tan, website, online', N'Active'),
    (15, N'Có thể xem lại hóa đơn không?', N'Bạn có thể xem lại lịch giao dịch và chi tiết hóa đơn trên website. Ngoài ra bạn có thể in biên lai cho hóa đơn đó nếu cần thiết', N'Thủ tục thanh toán', N'xem hóa đơn, xem hoa don, lịch giao dịch, lich giao dich, chi tiết hóa đơn, chi tiet hoa don, in biên lai, in bien lai', N'Active');

    SET IDENTITY_INSERT dbo.FAQ OFF;
    DBCC CHECKIDENT (N'dbo.FAQ', RESEED, 15);
END;
GO

-------------------------------------------------------------------------------
-- BỔ SUNG: DỮ LIỆU CHẤM CÔNG DEMO CHO NHÂN VIÊN VÀ PT
-------------------------------------------------------------------------------
PRINT N'Generating Demo Staff PT Attendance...';
GO

DECLARE @DemoNote nvarchar(500) = N'DEMO_ATTENDANCE_2026_07_01_TO_26';
DECLARE @StartDate date = CAST(N'2026-07-01' AS date);
DECLARE @EndDate date = CAST(N'2026-07-26' AS date);

;WITH DemoUsers AS
(
    SELECT v.UserID, v.UserRole, v.UserOffset
    FROM (VALUES
        (2, N'Staff', 0),
        (3, N'PT',    1),
        (5, N'PT',    2)
    ) v(UserID, UserRole, UserOffset)
    INNER JOIN dbo.Users u
        ON u.UserID = v.UserID
       AND u.IsDeleted = 0
),
DemoDates AS
(
    SELECT @StartDate AS WorkDate
    UNION ALL
    SELECT DATEADD(DAY, 1, WorkDate)
    FROM DemoDates
    WHERE WorkDate < @EndDate
),
DemoShifts AS
(
    SELECT *
    FROM (VALUES
        (N'Morning',   8 * 60,       12 * 60,      0),
        (N'Afternoon', 13 * 60 + 15, 16 * 60 + 45, 1),
        (N'Evening',   17 * 60,      20 * 60 + 30, 2)
    ) v(ShiftBlock, ShiftStartMinute, ShiftEndMinute, ShiftOffset)
),
DemoRows AS
(
    SELECT
        u.UserID,
        u.UserRole,
        d.WorkDate,
        s.ShiftBlock,
        s.ShiftStartMinute,
        s.ShiftEndMinute,
        (DATEDIFF(DAY, @StartDate, d.WorkDate) + u.UserOffset + (s.ShiftOffset * 2)) % 6 AS DemoPattern
    FROM DemoDates d
    CROSS JOIN DemoShifts s
    CROSS JOIN DemoUsers u
)
INSERT INTO dbo.StaffPTAttendance
    (UserID, UserRole, CheckedInAt, CheckedOutAt, ShiftBlock,
     Status, CheckedBy, Note, CreatedBy, CreatedDate,
     UpdatedBy, UpdatedDate, IsDeleted)
SELECT
    r.UserID,
    r.UserRole,
    DATEADD(MINUTE,
        r.ShiftStartMinute
        + CASE r.DemoPattern
            WHEN 1 THEN 10
            WHEN 3 THEN 10
            ELSE 2
          END,
        CAST(r.WorkDate AS datetime2)),
    CASE
        WHEN r.DemoPattern = 4 THEN NULL
        ELSE DATEADD(MINUTE,
            r.ShiftEndMinute
            + CASE r.DemoPattern
                WHEN 2 THEN -20
                WHEN 3 THEN -20
                ELSE 5
              END,
            CAST(r.WorkDate AS datetime2))
    END,
    r.ShiftBlock,
    N'Active',
    1,
    @DemoNote,
    N'Demo Admin',
    DATEADD(MINUTE,
        r.ShiftStartMinute
        + CASE r.DemoPattern
            WHEN 1 THEN 10
            WHEN 3 THEN 10
            ELSE 2
          END,
        CAST(r.WorkDate AS datetime2)),
    CASE WHEN r.DemoPattern = 4 THEN NULL ELSE N'1' END,
    CASE
        WHEN r.DemoPattern = 4 THEN NULL
        ELSE DATEADD(MINUTE,
            r.ShiftEndMinute
            + CASE r.DemoPattern
                WHEN 2 THEN -20
                WHEN 3 THEN -20
                ELSE 5
              END,
            CAST(r.WorkDate AS datetime2))
    END,
    0
FROM DemoRows r
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.StaffPTAttendance existing
    WHERE existing.UserID = r.UserID
      AND existing.UserRole = r.UserRole
      AND CAST(existing.CheckedInAt AS date) = r.WorkDate
      AND existing.ShiftBlock = r.ShiftBlock
      AND existing.IsDeleted = 0
)
OPTION (MAXRECURSION 100);
GO

