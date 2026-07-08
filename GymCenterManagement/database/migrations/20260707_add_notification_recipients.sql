USE [GymCenterManagement];
GO

IF OBJECT_ID(N'[dbo].[NotificationRecipients]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[NotificationRecipients] (
        [NotificationRecipientID] [int] IDENTITY(1,1) NOT NULL,
        [NotificationID] [int] NOT NULL,
        [UserID] [int] NOT NULL,
        [IsRead] [bit] NOT NULL CONSTRAINT [DF_NotificationRecipients_IsRead] DEFAULT ((0)),
        [ReadAt] [datetime2](7) NULL,
        [CreatedDate] [datetime2](7) NOT NULL CONSTRAINT [DF_NotificationRecipients_CreatedDate] DEFAULT (sysdatetime()),
        CONSTRAINT [PK_NotificationRecipients] PRIMARY KEY CLUSTERED ([NotificationRecipientID] ASC),
        CONSTRAINT [UQ_NotificationRecipients_Notification_User] UNIQUE ([NotificationID], [UserID]),
        CONSTRAINT [FK_NotificationRecipients_Notifications]
            FOREIGN KEY ([NotificationID]) REFERENCES [dbo].[Notifications] ([NotificationID]),
        CONSTRAINT [FK_NotificationRecipients_Users]
            FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
    );
END
GO

