use bt_qlsv_1707;
create table tblSinhVien(
sv_Maso int primary key,
sv_Hodem nvarchar(30),
sv_Ten nvarchar(15),
sv_Ngaysinh datetime(6),
sv_Lop int,
sv_DiemTB int,
foreign key (sv_Lop) references tblLop(l_ID)
);

create table tblLop(
l_ID int primary key,
l_Ten nvarchar(30),
l_Khoa int,
foreign key (l_Khoa) references tblKhoa(k_ID)
);
create table tblKhoa(
k_ID int primary key,
k_Ten nvarchar(20)
);

/* Liệt kê danh sách các sinh viên*/
select * from tblSinhvien;

/* Liệt kê danh sách các sinh viên (họ tên viết liền)*/
select sv_Maso,CONCAT(sv_Hodem,sv_Ten) as 'Ho ten' from tblSinhvien;

/* Liệt kê danh sách sinh viên: Mã số, họ đệm, tên, tuổi*/
select sv_Maso,sv_Hodem,sv_Ten,ROUND(DATEDIFF(CURDATE(), sv_Ngaysinh) / 365, 0) AS 'tuoi'
from tblSinhvien;

/* Liệt kê danh sách các lớp*/
select l_ID,l_Ten from tblLop;

/* Liệt kê danh sách các khoa*/
select * from tblKhoa;

/*Tìm những sinh viên thuộc khoa CNTT*/
select tblSinhvien.sv_Maso,tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblSinhvien.sv_Lop,tblKhoa.k_Ten 
from tblSinhvien
 inner join tblLop on tblSinhvien.sv_Lop = tblLop.l_ID
 inner join tblKhoa on tblLop.l_Khoa= tblKhoa.k_ID
 where k_Ten = 'cntt';
