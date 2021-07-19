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




/*Tên khoa, Họ tên, ngày sinh, điểm trung bình của sinh viên có điểm trung bình cao nhất khoa */
SELECT tblSinhvien.sv_Maso, tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblSinhvien.sv_Lop,tblKhoa.k_Ten , AVG(sv_DiemTB)
FROM tblSinhVien 
inner join tblLop on tblSinhvien.sv_Lop = tblLop.l_ID
 inner join tblKhoa on tblLop.l_Khoa= tblKhoa.k_ID
HAVING AVG(sv_DiemTB) >= 8;

/*Tên khoa, tên lớp, điểm trung bình của sinh viên (chú ý: liệt kê tất cả các khoa và lớp, kể cả khoa và lớp chưa có sinh viên)*/
SELECT tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblLop.l_Ten,tblKhoa.k_Ten , AVG(sv_DiemTB)
FROM tblSinhVien
 join tblLop on tblSinhvien.sv_Lop = tblLop.l_ID
 join tblKhoa on tblLop.l_Khoa= tblKhoa.k_ID
 group by tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblLop.l_Ten,tblKhoa.k_Ten;
 
 /*Tên khoa, tổng số sinh viên của khoa */
select tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten, count(sv_Maso) AS 'Số lượng học viên',tblKhoa.k_Ten
FROM tblSinhVien
 join tblLop on tblSinhvien.sv_Lop = tblLop.l_ID
 join tblKhoa on tblLop.l_Khoa= tblKhoa.k_ID
GROUP BY tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblKhoa.k_Ten;

/* Tên lớp, tổng số sinh viên của lớp*/ 
select tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten, count(sv_Maso) AS 'Số lượng học viên',tblLop.l_Ten
FROM tblSinhVien
 join tblLop on tblSinhvien.sv_Lop = tblLop.l_ID
 join tblKhoa on tblLop.l_Khoa= tblKhoa.k_ID
GROUP BY tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblLop.l_Ten;

/* Tên lớp, danh sách các sinh viên của lớp sắp xếp theo điểm trung bình giảm dần*/
SELECT tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblLop.l_Ten,tblKhoa.k_Ten , AVG(sv_DiemTB)
FROM tblSinhVien
 join tblLop on tblSinhvien.sv_Lop = tblLop.l_ID
 join tblKhoa on tblLop.l_Khoa= tblKhoa.k_ID
  group by tblSinhvien.sv_Hodem,tblSinhvien.sv_Ten,tblLop.l_Ten,tblKhoa.k_Ten
 ORDER BY  sv_DiemTB DESC ;
 
 /*Số lượng sinh viên loại giỏi, loại khá, loại trung bình (trong cùng 1 query)*/
SELECT 
count(case when sv_DiemTB>=9 then 1 else null end) as 'gioi',
count(case when sv_DiemTB<9 and sv_DiemTB>7 then 1 else null end) as 'kha',
count(case when sv_DiemTB<=7 then 1 else null end) as 'trunh binh'
from tblSinhvien;
/* Số lượng sinh viên loại giỏi, khá, trung bình của từng lớp (trong cùng 1 query)*/
SELECT l_Ten,
sum (if (sv_DiemTB >= 9,1,0)) as 'gioi',
sum (if (sv_DiemTB<9 and sv_DiemTB>7,1,0)) as 'kha',
sum (if (sv_DiemTB <=7,1,0)) as 'trung binh'
FROM tblSinhvien
 join tblLop on tblSinhvien.sv_Lop = tblLop.l_ID;

 