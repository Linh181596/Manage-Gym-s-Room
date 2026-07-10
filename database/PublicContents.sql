USE [GymCenterManagement];
GO

IF OBJECT_ID(N'dbo.PublicContents', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.PublicContents (
        ContentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Summary NVARCHAR(500) NOT NULL,
        Body NVARCHAR(MAX) NOT NULL,
        ContentType NVARCHAR(20) NOT NULL,
        Category NVARCHAR(100) NULL,
        ThumbnailURL NVARCHAR(500) NULL,
        Status NVARCHAR(20) NOT NULL CONSTRAINT DF_PublicContents_Status DEFAULT N'Draft',
        PublishedAt DATETIME2 NULL,
        CreatedBy NVARCHAR(100) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_PublicContents_CreatedAt DEFAULT SYSDATETIME(),
        UpdatedBy NVARCHAR(100) NULL,
        UpdatedAt DATETIME2 NULL,
        IsDeleted BIT NOT NULL CONSTRAINT DF_PublicContents_IsDeleted DEFAULT 0,
        CONSTRAINT CK_PublicContents_Type CHECK (ContentType IN (N'BLOG', N'POLICY')),
        CONSTRAINT CK_PublicContents_Status CHECK (Status IN (N'Draft', N'Published', N'Hidden'))
    );

    CREATE INDEX IX_PublicContents_Public
        ON dbo.PublicContents(ContentType, Status, IsDeleted, PublishedAt DESC);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.PublicContents WHERE ContentType = N'BLOG')
BEGIN
    INSERT INTO dbo.PublicContents
        (Title, Summary, Body, ContentType, Category, ThumbnailURL, Status, PublishedAt, CreatedBy)
    VALUES
        (N'Vi sao nen khoi dong truoc khi tap?',
         N'Khoi dong giup co the san sang van dong va giam nguy co dau moi sau tap.',
         N'Khoi dong 5 den 10 phut truoc buoi tap giup tang nhip tim, lam nong khop va cai thien kha nang kiem soat dong tac. Hoi vien nen bat dau bang cac dong tac nhe, sau do tang dan cuong do theo muc tieu tap.',
         N'BLOG', N'Khoi dong', N'img/testimonial-1.jpg', N'Published', SYSDATETIME(), N'System'),
        (N'Phuc hoi dung cach sau buoi tap',
         N'Nghi ngoi, gian co va bo sung nuoc la nen tang de duy tri lich tap deu.',
         N'Sau buoi tap, co the can thoi gian de phuc hoi. Hoi vien nen ngu du, uong nuoc, gian co nhe va sap xep cuong do tap phu hop de tranh qua tai.',
         N'BLOG', N'Phuc hoi', N'assets/uploads/pt-avatar/Nguyen_Thi_Nga_Yoga.jpg', N'Published', SYSDATETIME(), N'System');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.PublicContents WHERE ContentType = N'POLICY')
BEGIN
    INSERT INTO dbo.PublicContents
        (Title, Summary, Body, ContentType, Category, ThumbnailURL, Status, PublishedAt, CreatedBy)
    VALUES
        (N'Chinh sach hoan tien va huy goi',
         N'Hoan tien hoac huy goi duoc xem xet theo tinh trang goi va tung truong hop cu the.',
         N'Hoi vien can lien he quay le tan de duoc kiem tra thong tin goi, hoa don va thoi gian su dung. Ket qua xu ly phu thuoc vao dieu kien cua tung goi va quy dinh hien hanh cua phong tap.',
         N'POLICY', N'Hoan tien', NULL, N'Published', SYSDATETIME(), N'System'),
        (N'Chinh sach bao luu va chuyen nhuong',
         N'Bao luu hoac chuyen nhuong can duoc xac nhan truoc khi thuc hien.',
         N'Phong tap ho tro kiem tra dieu kien bao luu hoac chuyen nhuong tai quay le tan. Hoi vien can cung cap thong tin tai khoan, goi dang su dung va ly do yeu cau.',
         N'POLICY', N'Bao luu', NULL, N'Published', SYSDATETIME(), N'System'),
        (N'Noi quy hoi vien',
         N'Hoi vien can tuan thu quy dinh ve trang phuc, ve sinh, thiet bi va khong gian chung.',
         N'Hoi vien vui long su dung thiet bi dung cach, giu ve sinh khu tap, ton trong nguoi tap khac va tuan thu huong dan cua nhan vien. Cac quy dinh ve quay video, khach di cung hoac bao mat thong tin can duoc xac nhan voi le tan.',
         N'POLICY', N'Noi quy', NULL, N'Published', SYSDATETIME(), N'System');
END
GO
