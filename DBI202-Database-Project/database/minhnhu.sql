USE SmartSiteLab5

CREATE TABLE dbo.WORKER (
    WorkerID INT IDENTITY(1,1) CONSTRAINT PK_WORKER PRIMARY KEY,
    ContractorID INT NOT NULL CONSTRAINT FK_WORKER_CONTRACTOR REFERENCES dbo.CONTRACTOR(ContractorID),
    FullName NVARCHAR(120) NOT NULL,
    JobRole NVARCHAR(80) NOT NULL,
    IsActive NVARCHAR(50) NOT NULL CONSTRAINT DF_WORKER_Status DEFAULT (N'Chờ xác minh')
);
CREATE TABLE dbo.ASSIGNMENT (
    AssignmentID INT IDENTITY(1,1) CONSTRAINT PK_ASSIGNMENT PRIMARY KEY,
    WorkerID INT NOT NULL CONSTRAINT FK_ASSIGNMENT_WORKER REFERENCES dbo.WORKER(WorkerID),
    ZoneID INT NOT NULL CONSTRAINT FK_ASSIGNMENT_ZONE REFERENCES dbo.ZONE(ZoneID),
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    IsActive NVARCHAR(50) NOT NULL CONSTRAINT DF_ASSIGNMENT_Status DEFAULT (N'Đang thực hiện'),
    CONSTRAINT CK_ASSIGNMENT_Date CHECK (EndDate IS NULL OR EndDate >= StartDate)
);
CREATE TABLE dbo.SAFETY_CERTIFICATE (
    CertificateID INT IDENTITY(1,1) CONSTRAINT PK_SAFETY_CERTIFICATE PRIMARY KEY,
    WorkerID INT NOT NULL CONSTRAINT FK_CERTIFICATE_WORKER REFERENCES dbo.WORKER(WorkerID),
    CertificateType NVARCHAR(100) NOT NULL,
    IssuedDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    IsActive NVARCHAR(50) NOT NULL CONSTRAINT DF_CERTIFICATE_Status DEFAULT (N'Còn hiệu lực'),
    CONSTRAINT CK_CERTIFICATE_Dates CHECK (ExpiryDate > IssuedDate),
    CONSTRAINT UQ_CERTIFICATE_WorkerType UNIQUE (WorkerID, CertificateType)
);
CREATE TABLE dbo.VISITOR (
    VisitorID INT IDENTITY(1,1) CONSTRAINT PK_VISITOR PRIMARY KEY, 
    FullName NVARCHAR(120) NOT NULL,
    Phone VARCHAR(15) NULL,
    Email VARCHAR(100) NULL,
    Company NVARCHAR(150) NULL,
    IdNumber VARCHAR(20) NOT NULL,
    Status NVARCHAR(50) NOT NULL CONSTRAINT DF_VISITOR_Status DEFAULT (N'Hợp lệ')
);
CREATE TABLE dbo.VISIT (
    VisitID INT IDENTITY(1,1) CONSTRAINT PK_VISIT PRIMARY KEY, 
    VisitorID INT NOT NULL CONSTRAINT FK_VISIT_VISITOR REFERENCES dbo.VISITOR(VisitorID),
    SiteID INT NOT NULL CONSTRAINT FK_VISIT_SITE REFERENCES dbo.Contruction_site(SiteID), 
    VisitDate DATE NOT NULL,
    Purpose NVARCHAR(250) NULL,
    ApprovalStatus NVARCHAR(50) NOT NULL CONSTRAINT DF_VISIT_Approval DEFAULT (N'Chờ duyệt'),
    CheckInTime DATETIME NULL,
    CheckOutTime DATETIME NULL,
    Status NVARCHAR(50) NOT NULL CONSTRAINT DF_VISIT_Status DEFAULT (N'Chờ xử lý')
);

--INSERT DATA

--WORKER
INSERT INTO dbo.WORKER (ContractorID, FullName, JobRole, IsActive) VALUES 
(1, N'Nguyễn Văn Hùng', N'Thợ hồ', N'Đã xác minh'),
(1, N'Trần Minh Tuấn', N'Thợ hồ', N'Đã xác minh'),
(3, N'Lê Văn Đức', N'Thợ sắt', N'Đã xác minh'),
(3, N'Phạm Quốc Bảo', N'Thợ cốp pha', N'Chờ xác minh'),
(2, N'Võ Thanh Sơn', N'Thợ điện', N'Đã xác minh'),
(2, N'Đặng Hoàng Nam', N'Thợ điện', N'Đã xác minh'),
(4, N'Bùi Văn Long', N'Thợ hàn', N'Đã xác minh'),
(4, N'Huỳnh Minh Khoa', N'Thợ hàn', N'Đã xác minh'),
(4, N'Ngô Thành Đạt', N'Thợ giàn giáo', N'Đã xác minh'),
(4, N'Dương Văn Phúc', N'Thợ giàn giáo', N'Đã xác minh'),
(5, N'Trương Quang Vinh', N'Thợ lái máy', N'Đã xác minh'),
(5, N'Lý Văn Thắng', N'Thợ lái máy', N'Đã xác minh'),
(5, N'Phan Thị Lan', N'Thợ sơn', N'Đã xác minh'),
(5, N'Đỗ Thị Mai', N'Thợ sơn', N'Đã xác minh'),
(2, N'Hồ Văn Tâm', N'Thợ nước', N'Đã xác minh'),
(2, N'Mai Văn Hải', N'Thợ nước', N'Hết hạn'),
(3, N'Cao Minh Trí', N'Thợ sắt', N'Đã xác minh'),
(1, N'Tạ Văn Lộc', N'Thợ hồ', N'Đã xác minh'),
(3, N'Lâm Quốc Việt', N'Thợ cốp pha', N'Đã xác minh'),
(1, N'Châu Thị Hạnh', N'Thợ hồ', N'Đã xác minh');

SELECT *
FROM dbo.WORKER

--ASSIGNMENT
INSERT INTO dbo.ASSIGNMENT (WorkerID, ZoneID, StartDate, EndDate, IsActive) VALUES 
(1, 1, '2026-03-01', '2026-12-31', N'Đang thực hiện'),
(2, 1, '2026-03-01', '2026-12-31', N'Đang thực hiện'),
(3, 2, '2026-04-10', '2026-11-30', N'Đang thực hiện'),
(4, 2, '2026-04-10', '2026-11-30', N'Đang thực hiện'),
(5, 3, '2026-05-05', '2026-12-15', N'Đang thực hiện'),
(6, 3, '2026-05-05', '2026-12-15', N'Đang thực hiện'),
(7, 4, '2026-02-01', '2026-08-31', N'Hoàn thành'),
(8, 4, '2026-02-01', '2026-08-31', N'Hoàn thành'),
(9, 5, '2026-06-01', '2026-12-31', N'Đang thực hiện'),
(10, 5, '2026-06-01', '2026-12-31', N'Đang thực hiện'),
(11, 1, '2026-01-15', '2026-06-30', N'Hoàn thành'),
(12, 2, '2026-07-01', '2026-12-31', N'Đang thực hiện'),
(13, 3, '2026-09-01', '2027-01-31', N'Đang thực hiện'),
(14, 4, '2026-09-01', '2027-01-31', N'Đang thực hiện'),
(15, 5, '2026-08-01', '2026-10-15', N'Hoàn thành'),
(16, 2, '2026-08-01', '2026-12-31', N'Tạm dừng'),
(17, 4, '2026-09-15', '2026-12-31', N'Đang thực hiện'),
(18, 3, '2026-03-01', '2026-09-30', N'Hoàn thành'),
(19, 5, '2026-10-01', '2027-02-28', N'Đang thực hiện'),
(20, 1, '2026-04-01', '2026-12-31', N'Đang thực hiện');

SELECT *
FROM dbo.ASSIGNMENT

--SAFETY_CERTIFICATE
INSERT INTO dbo.SAFETY_CERTIFICATE (WorkerID, CertificateType, IssuedDate, ExpiryDate, IsActive) VALUES 
(1, N'An toàn lao động nhóm 3', '2025-03-10', '2027-03-10', N'Còn hiệu lực'),
(2, N'An toàn lao động nhóm 3', '2024-05-20', '2026-05-20', N'Hết hạn'),
(3, N'An toàn lao động nhóm 3', '2025-06-01', '2027-06-01', N'Còn hiệu lực'),
(4, N'An toàn lao động nhóm 3', '2026-02-15', '2028-02-15', N'Còn hiệu lực'),
(5, N'An toàn điện', '2025-01-12', '2027-01-12', N'Còn hiệu lực'),
(6, N'An toàn điện', '2024-09-09', '2026-09-09', N'Hết hạn'),
(7, N'Chứng chỉ hàn', '2025-04-18', '2028-04-18', N'Còn hiệu lực'),
(8, N'Chứng chỉ hàn', '2024-12-01', '2027-12-01', N'Còn hiệu lực'),
(9, N'Làm việc trên cao', '2025-07-07', '2027-07-07', N'Còn hiệu lực'),
(10, N'Làm việc trên cao', '2024-10-25', '2026-10-25', N'Hết hạn'),
(11, N'Vận hành máy xây dựng', '2025-02-20', '2028-02-20', N'Còn hiệu lực'),
(12, N'Vận hành máy xây dựng', '2026-01-05', '2029-01-05', N'Còn hiệu lực'),
(13, N'Làm việc trên cao', '2025-08-30', '2027-08-30', N'Còn hiệu lực'),
(14, N'An toàn lao động nhóm 3', '2025-11-11', '2027-11-11', N'Còn hiệu lực'),
(15, N'An toàn lao động nhóm 3', '2024-06-06', '2026-06-06', N'Hết hạn'),
(17, N'An toàn lao động nhóm 3', '2026-03-03', '2028-03-03', N'Còn hiệu lực'),
(18, N'Sơ cấp cứu', '2025-09-14', '2027-09-14', N'Còn hiệu lực'),
(19, N'Làm việc trên cao', '2026-05-22', '2028-05-22', N'Còn hiệu lực'),
(20, N'An toàn lao động nhóm 3', '2025-10-01', '2027-10-01', N'Còn hiệu lực'),
(7, N'Làm việc trên cao', '2025-05-05', '2027-05-05', N'Còn hiệu lực');


SELECT *
FROM dbo.SAFETY_CERTIFICATE

--VISITOR
INSERT INTO dbo.VISITOR (FullName, Phone, Email, Company, IdNumber, Status) VALUES 
(N'Nguyễn Hoàng Anh', '0910137531', 'visitor01@example.com', N'Công ty TNHH Tư vấn Giám sát An Phát', '079201000001', N'Hợp lệ'),
(N'Trần Thị Bích Ngọc', '0910275062', 'visitor02@example.com', N'Ban QLDA Đầu tư Xây dựng Khu vực 1', '079201000002', N'Hợp lệ'),
(N'Lê Quang Huy', '0910412593', 'visitor03@example.com', N'Công ty CP Vật liệu Xây dựng Hòa Bình', '079201000003', N'Hợp lệ'),
(N'Phạm Thị Thu Hà', '0910550124', 'visitor04@example.com', N'Công ty TNHH Thiết bị Xây dựng Nam Việt', '079201000004', N'Hợp lệ'),
(N'Võ Minh Châu', '0910687655', 'visitor05@example.com', N'Sở Xây dựng TP. Hồ Chí Minh', '079201000005', N'Hợp lệ'),
(N'Đặng Văn Khải', '0910825186', 'visitor06@example.com', N'Công ty CP Bê tông Sài Gòn', '079201000006', N'Hợp lệ'),
(N'Bùi Thị Ngân', '0910962717', 'visitor07@example.com', N'Công ty TNHH Kiểm định Xây dựng Đại Nam', '079201000007', N'Hợp lệ'),
(N'Huỳnh Gia Phúc', '0911100248', 'visitor08@example.com', N'Chủ đầu tư Tập đoàn Phú Gia', '079201000008', N'Tạm khóa'),
(N'Ngô Thị Hồng Nhung', '0911237779', 'visitor09@example.com', N'Công ty CP Thép Việt Đạt', '079201000009', N'Hợp lệ'),
(N'Dương Quốc Thái', '0911375310', 'visitor10@example.com', N'Công ty TNHH Nội thất Minh Long', '079201000010', N'Hợp lệ'),
(N'Trương Văn Bình', '0911512841', 'visitor11@example.com', N'Công ty TNHH Tư vấn Giám sát An Phát', '079201000011', N'Hợp lệ'),
(N'Lý Thị Kim Chi', '0911650372', 'visitor12@example.com', N'Ban QLDA Đầu tư Xây dựng Khu vực 1', '079201000012', N'Hợp lệ'),
(N'Phan Anh Dũng', '0911787903', 'visitor13@example.com', N'Công ty CP Vật liệu Xây dựng Hòa Bình', '079201000013', N'Hợp lệ'),
(N'Đỗ Minh Nhật', '0911925434', 'visitor14@example.com', N'Công ty TNHH Thiết bị Xây dựng Nam Việt', '079201000014', N'Hợp lệ'),
(N'Hồ Thị Thanh Tâm', '0912062965', 'visitor15@example.com', N'Sở Xây dựng TP. Hồ Chí Minh', '079201000015', N'Hợp lệ'),
(N'Mai Xuân Trường', '0912200496', 'visitor16@example.com', N'Công ty CP Bê tông Sài Gòn', '079201000016', N'Hợp lệ'),
(N'Cao Thị Diễm My', '0912338027', 'visitor17@example.com', N'Công ty TNHH Kiểm định Xây dựng Đại Nam', '079201000017', N'Hợp lệ'),
(N'Tạ Đình Khôi', '0912475558', 'visitor18@example.com', N'Chủ đầu tư Tập đoàn Phú Gia', '079201000018', N'Hợp lệ'),
(N'Lâm Thị Yến', '0912613089', 'visitor19@example.com', N'Công ty CP Thép Việt Đạt', '079201000019', N'Tạm khóa'),
(N'Châu Văn Tiến', '0912750620', 'visitor20@example.com', N'Công ty TNHH Nội thất Minh Long', '079201000020', N'Hợp lệ');

SELECT *
FROM dbo.VISITOR

--VISIT
INSERT INTO dbo.VISIT (VisitorID, SiteID, VisitDate, Purpose, ApprovalStatus, CheckInTime, CheckOutTime, Status) VALUES 
(1, 1, '2026-09-15', N'Giám sát tiến độ', N'Đã duyệt', '2026-09-15 08:00:00', '2026-09-15 11:30:00', N'Đã ra'),
(1, 1, '2026-09-16', N'Họp với chủ đầu tư', N'Đã duyệt', '2026-09-16 09:00:00', '2026-09-16 12:00:00', N'Đã ra'),
(2, 1, '2026-09-18', N'Giao vật tư', N'Đã duyệt', '2026-09-18 07:30:00', '2026-09-18 09:00:00', N'Đã ra'),
(2, 1, '2026-09-20', N'Kiểm tra an toàn', N'Đã duyệt', '2026-09-20 08:30:00', '2026-09-20 16:00:00', N'Đã ra'),
(3, 1, '2026-09-22', N'Nghiệm thu', N'Đã duyệt', '2026-09-22 08:00:00', '2026-09-22 15:30:00', N'Đã ra'),
(3, 1, '2026-09-25', N'Giao vật tư', N'Đã duyệt', '2026-09-25 06:45:00', '2026-09-25 08:15:00', N'Đã ra'),
(4, 1, '2026-09-28', N'Kiểm định chất lượng', N'Đã duyệt', '2026-09-28 08:00:00', '2026-09-28 14:00:00', N'Đã ra'),
(4, 1, '2026-09-30', N'Tham quan công trường', N'Từ chối', NULL, NULL, N'Đã hủy'),
(5, 1, '2026-10-02', N'Giám sát tiến độ', N'Đã duyệt', '2026-10-02 08:00:00', '2026-10-02 11:00:00', N'Đã ra'),
(5, 1, '2026-10-05', N'Giao vật tư', N'Đã duyệt', '2026-10-05 07:00:00', '2026-10-05 08:30:00', N'Đã ra'),
(1, 1, '2026-10-08', N'Kiểm tra an toàn', N'Đã duyệt', '2026-10-08 08:30:00', '2026-10-08 12:00:00', N'Đã ra'),
(2, 1, '2026-10-12', N'Họp với chủ đầu tư', N'Đã duyệt', '2026-10-12 09:00:00', '2026-10-12 11:45:00', N'Đã ra'),
(3, 1, '2026-10-15', N'Nghiệm thu', N'Đã duyệt', '2026-10-15 08:00:00', '2026-10-15 16:30:00', N'Đã ra'),
(4, 1, '2026-10-19', N'Giao vật tư', N'Đã duyệt', '2026-10-19 07:15:00', '2026-10-19 09:00:00', N'Đã ra'),
(1, 2, '2026-10-22', N'Giám sát tiến độ', N'Đã duyệt', '2026-10-22 08:00:00', '2026-10-22 10:45:00', N'Đã ra'),
(15, 1, '2026-10-26', N'Tham quan công trường', N'Từ chối', NULL, NULL, N'Đã hủy'),
(16, 1, '2026-10-29', N'Kiểm định chất lượng', N'Đã duyệt', '2026-10-29 08:30:00', '2026-10-29 15:00:00', N'Đã ra'),
(17, 1, '2026-10-31', N'Giao vật tư', N'Đã duyệt', '2026-10-31 07:30:00', NULL, N'Đang trong công trường'),
(18, 1, '2026-11-03', N'Kiểm tra an toàn', N'Chờ duyệt', NULL, NULL, N'Chờ xử lý'),
(20, 1, '2026-11-05', N'Họp với chủ đầu tư', N'Chờ duyệt', NULL, NULL, N'Chờ xử lý');

SELECT *
FROM dbo.VISIT