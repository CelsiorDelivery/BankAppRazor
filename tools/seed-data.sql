-- Bank database seed script
-- Source     : dbBank.mdb
-- Generated  : 2026-09-18 19:33:11
-- Regenerate : powershell -File tools\Export-BankData.ps1
--
-- This is a readable snapshot. The authoritative data ships as the
-- committed .mdb files; this script exists for review and recovery.

-- ============================================================
-- Table: LOGIN
-- ============================================================
CREATE TABLE [LOGIN] (
    [Login_Name] LONGTEXT,
    [Password] LONGTEXT
);

INSERT INTO [LOGIN] ([Login_Name], [Password]) VALUES ('naresh', 'naresh');

-- 1 row(s) in [LOGIN]

-- ============================================================
-- Table: tblAccount
-- ============================================================
CREATE TABLE [tblAccount] (
    [AccountID] INTEGER,
    [AccountType] TEXT(50),
    [Cheque] CURRENCY,
    [Nocheque] CURRENCY,
    [InterestRate] INTEGER
);

INSERT INTO [tblAccount] ([AccountID], [AccountType], [Cheque], [Nocheque], [InterestRate]) VALUES (1, 'Savings', 1500, 1000, 2);

-- 1 row(s) in [tblAccount]

-- ============================================================
-- Table: tblCustomers
-- ============================================================
CREATE TABLE [tblCustomers] (
    [FirstName] LONGTEXT,
    [LastName] LONGTEXT,
    [MiddleName] LONGTEXT,
    [CustomerID] INTEGER,
    [AccountNo] INTEGER,
    [Sex] LONGTEXT,
    [DOB] LONGTEXT,
    [Cheque] LONGTEXT,
    [Address] LONGTEXT,
    [Pincode] INTEGER,
    [PhoneNo] INTEGER,
    [DateOfOpen] DATETIME,
    [Balance] CURRENCY,
    [AccountType] LONGTEXT,
    [Nominee] LONGTEXT,
    [Relationship] LONGTEXT,
    [Relationstatus] LONGTEXT,
    [MobileNO] DOUBLE
);

INSERT INTO [tblCustomers] ([FirstName], [LastName], [MiddleName], [CustomerID], [AccountNo], [Sex], [DOB], [Cheque], [Address], [Pincode], [PhoneNo], [DateOfOpen], [Balance], [AccountType], [Nominee], [Relationship], [Relationstatus], [MobileNO]) VALUES ('KUNAL', 'GORE', 'SHASHIKANT', 2005, 105, 'MALE', '29/02/1987', 'YES', 'BHAYANDER, GOLDEN NEST', 400043, 66661234, #02/08/2008 00:00:00#, 178163, 'SAVINGS', 'SHASHIKANT', 'FATHER', 'MAJOR', 9870325873);
INSERT INTO [tblCustomers] ([FirstName], [LastName], [MiddleName], [CustomerID], [AccountNo], [Sex], [DOB], [Cheque], [Address], [Pincode], [PhoneNo], [DateOfOpen], [Balance], [AccountType], [Nominee], [Relationship], [Relationstatus], [MobileNO]) VALUES ('NARESH', 'DILIP', 'DILIP SINGH', 2006, 106, 'MALE', '2/12/1987', 'YES', '12345678', 400083, 26251605, #03/11/2008 00:00:00#, 12239, 'SAVINGS', 'DILIP', 'FATHER', 'MAJOR', 9869601310);
INSERT INTO [tblCustomers] ([FirstName], [LastName], [MiddleName], [CustomerID], [AccountNo], [Sex], [DOB], [Cheque], [Address], [Pincode], [PhoneNo], [DateOfOpen], [Balance], [AccountType], [Nominee], [Relationship], [Relationstatus], [MobileNO]) VALUES ('BUNTY', 'GAVANANG', 'NARAYAN', 2007, 107, 'MALE', '21/05/1987', 'YES', 'GJKHKHK', 400087, 28342144, #03/13/2008 00:00:00#, 533957, 'SAVINGS', 'AMIT', 'FRIENDS', 'MAJOR', 9892017696);
INSERT INTO [tblCustomers] ([FirstName], [LastName], [MiddleName], [CustomerID], [AccountNo], [Sex], [DOB], [Cheque], [Address], [Pincode], [PhoneNo], [DateOfOpen], [Balance], [AccountType], [Nominee], [Relationship], [Relationstatus], [MobileNO]) VALUES ('RITESH', 'SHARMA', 'BABAN', 2008, 108, 'MALE', '18/02/1987', 'YES', 'VIKHROLI,HILL VIEW BUILDING, LBS MARG', 400083, 25787232, #03/14/2008 00:00:00#, 7000, 'SAVINGS', 'MANJIT', 'BROTHER', 'MAJOR', 9901265289);
INSERT INTO [tblCustomers] ([FirstName], [LastName], [MiddleName], [CustomerID], [AccountNo], [Sex], [DOB], [Cheque], [Address], [Pincode], [PhoneNo], [DateOfOpen], [Balance], [AccountType], [Nominee], [Relationship], [Relationstatus], [MobileNO]) VALUES ('AMIT', 'PANCHAL', 'TUKARAM', 2002, 102, 'MALE', '18/02/1987', 'NO', 'LINK ROAD SE 5 MIN , SV ROAD ,  MALAD (WEST)', 400063, 28882256, #01/28/2008 00:00:00#, 544636.14, 'SAVINGS', 'NARAYAN', 'FATHER', 'MAJOR', 9999999999);
INSERT INTO [tblCustomers] ([FirstName], [LastName], [MiddleName], [CustomerID], [AccountNo], [Sex], [DOB], [Cheque], [Address], [Pincode], [PhoneNo], [DateOfOpen], [Balance], [AccountType], [Nominee], [Relationship], [Relationstatus], [MobileNO]) VALUES ('SUBHASH', 'VANJALE', 'VITHOBA', 2003, 103, 'MALE', '18/09/1986', 'YES', 'LINK ROAD SE 5 MIN , MALAD(WEST) , MUMBAI-400065', 400083, 25785650, #02/19/2008 00:00:00#, 75905, 'SAVINGS', 'VITHOBA', 'FATHER', 'MAJOR', 9920888003);
INSERT INTO [tblCustomers] ([FirstName], [LastName], [MiddleName], [CustomerID], [AccountNo], [Sex], [DOB], [Cheque], [Address], [Pincode], [PhoneNo], [DateOfOpen], [Balance], [AccountType], [Nominee], [Relationship], [Relationstatus], [MobileNO]) VALUES ('RANJIT', 'PARKHE', 'GAJANAN', 2004, 104, 'MALE', '25/06/1987', 'NO', 'MALAD(EAST)', 400059, 28882254, #02/11/2008 00:00:00#, 111118, 'SAVINGS', 'GAJANAN', 'FATHER', 'MAJOR', 9819178680);

-- 7 row(s) in [tblCustomers]

-- ============================================================
-- Table: tbltransaction
-- ============================================================
CREATE TABLE [tbltransaction] (
    [TransactionID] INTEGER,
    [CustomerID] INTEGER,
    [AccountNo] INTEGER,
    [transactionType] LONGTEXT,
    [Amount] CURRENCY,
    [Balance] CURRENCY,
    [Mode] TEXT(100),
    [ChequeNo] LONGTEXT,
    [BankName] LONGTEXT,
    [Date] LONGTEXT,
    [Month] LONGTEXT
);

INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (1, 2002, 102, 'Withdraw', 500, 70171.72, 'N/A', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (2, 2002, 102, 'Withdraw', 400, 69771.72, 'N/A', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (3, 2002, 102, 'Withdraw', 500, 69271.72, 'N/A', 'N/A', 'N/A', '3/19/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (4, 2003, 103, 'Withdraw', 1222, 67564, 'N/A', 'N/A', 'N/A', '3/19/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (5, 2003, 103, 'Withdraw', 1213, 66351, 'N/A', 'N/A', 'N/A', '3/18/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (6, 2003, 103, 'Withdraw', 5645, 60706, 'N/A', 'N/A', 'N/A', '3/18/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (7, 2004, 104, 'Withdraw', 256, 99283, 'N/A', 'N/A', 'N/A', '3/17/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (8, 2004, 104, 'Withdraw', 4566, 94717, 'N/A', 'N/A', 'N/A', '3/17/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (9, 2004, 104, 'Withdraw', 456, 94261, 'N/A', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (10, 2005, 105, 'Withdraw', 456, 499455, 'N/A', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (11, 2005, 105, 'Withdraw', 54645, 444810, 'N/A', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (12, 2002, 102, 'Deposit', 213, 69484.72, 'CASH', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (13, 2002, 102, 'Deposit', 323, 69807.72, 'CASH', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (14, 2003, 103, 'Deposit', 123, 60829, 'CASH', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (15, 2003, 103, 'Deposit', 12312, 73141, 'CASH', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (16, 2004, 104, 'Deposit', 12312, 106573, 'CASH', 'N/A', 'N/A', '3/18/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (17, 2004, 104, 'Deposit', 4545, 111118, 'CASH', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (18, 2005, 105, 'Deposit', 4565, 449375, 'CASH', 'N/A', 'N/A', '3/18/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (19, 2005, 105, 'Deposit', 1231, 450606, 'CASH', 'N/A', 'N/A', '3/12/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (20, 2005, 105, 'Deposit', 4566, 455172, 'CASH', 'N/A', 'N/A', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (21, 2002, 102, 'Interest', 1396.1544, 71203.8744, 'N/A', 'N/A', 'N/A', '3/18/2008', 'January / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (22, 2002, 102, 'Interest', 1424.0775, 72627.9519, 'N/A', 'N/A', 'N/A', '3/18/2008', 'February / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (23, 2002, 102, 'Interest', 1452.559, 74080.5109, 'N/A', 'N/A', 'N/A', '3/20/2008', 'March / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (24, 2003, 103, 'Interest', 1462.82, 74603.82, 'N/A', 'N/A', 'N/A', '3/12/2008', 'January / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (25, 2003, 103, 'Interest', 1462.82, 74603.82, 'N/A', 'N/A', 'N/A', '3/17/2008', 'February / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (26, 2003, 103, 'Interest', 1462.82, 74603.82, 'N/A', 'N/A', 'N/A', '3/20/2008', 'March / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (27, 2004, 104, 'Interest', 2222.36, 113340.36, 'N/A', 'N/A', 'N/A', '3/19/2008', 'January / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (28, 2004, 104, 'Interest', 2222.36, 113340.36, 'N/A', 'N/A', 'N/A', '3/17/2008', 'February / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (29, 2005, 105, 'Interest', 9103.44, 464275.44, 'N/A', 'N/A', 'N/A', '3/17/2008', 'January / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (30, 2005, 105, 'Interest', 9103.44, 464275.44, 'N/A', 'N/A', 'N/A', '3/20/2008', 'February / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (31, 2005, 105, 'Interest', 9103.44, 464275.44, 'N/A', 'N/A', 'N/A', '3/20/2008', 'March / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (32, 2002, 102, 'Withdraw', 5200, 459075.44, 'N/A', 'N/A', 'N/A', '3/13/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (33, 2002, 102, 'Deposit', 1222, 460297.44, 'CHEQUE', '531753', 'Bank of Baroda', '3/17/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (34, 2002, 102, 'Deposit', 7876, 468173.44, 'CHEQUE', '57563`', 'ALLAHABAD BANK', '3/18/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (35, 2002, 102, 'Deposit', 989, 469162.44, 'CHEQUE', '999900', 'SBI', '3/17/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (36, 2002, 102, 'Deposit', 353, 469515.44, 'CASH', 'N/A', 'N/A', '3/18/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (37, 2002, 102, 'Deposit', 45645, 515160.44, 'CHEQUE', '890456', 'AXIS BANK', '3/18/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (38, 2002, 102, 'Deposit', 121, 515281.44, 'CHEQUE', '346213', 'KOTAK MAHINDRA', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (39, 2002, 102, 'Deposit', 121, 515402.44, 'CHEQUE', '555663', 'HDFC', '3/20/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (40, 2002, 102, 'Deposit', 222222222222, 2222624.44, 'CHEQUE', '678768', 'HSBC', '3/19/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (41, 2002, 102, 'Withdraw', 0.0000, 22222624.44, 'N/A', 'N/A', 'N/A', '3/13/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (42, 2002, 102, 'Withdraw', 121222222222, 101000402.44, 'N/A', 'N/A', 'N/A', '3/13/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (43, 2005, 105, 'Deposit', 45444444444444, 45444616, 'CHEQUE', '121333', 'HSBC', '3/13/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (44, 2005, 105, 'Withdraw', 45444444444444, 455172, 'N/A', 'N/A', 'N/A', '3/13/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (45, 2005, 105, 'Withdraw', 300000, 155172, 'N/A', 'N/A', 'N/A', '3/13/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (46, 2002, 102, 'Withdraw', 23, 101379.44, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (47, 2002, 102, 'Deposit', 1212, 101591.44, 'CHEQUE', '123456', 'KOTAK', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (48, 2002, 102, 'Deposit', 123, 1010714.44, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (49, 2003, 103, 'Deposit', 23, 73164, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (50, 2003, 103, 'Deposit', 234, 73398, 'CHEQUE', '12345', 'SBI', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (51, 2002, 102, 'Deposit', 122, 1010836.44, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (52, 2003, 103, 'Deposit', 232, 73630, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (53, 2003, 103, 'Deposit', 123, 73753, 'CHEQUE', '12345', 'ASD', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (54, 2003, 103, 'Deposit', 1212, 74965, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (55, 2003, 103, 'Deposit', 232, 75197, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (56, 2003, 103, 'Deposit', 232, 75429, 'CHEQUE', '123456', 'AXIS BANK', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (57, 2003, 103, 'Deposit', 12, 75441, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (58, 2003, 103, 'Deposit', 343, 75784, 'CHEQUE', '111', 'AXIS BANK', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (59, 2003, 103, 'Withdraw', 23, 75761, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (60, 2003, 103, 'Interest', 1515.22, 77276.22, 'N/A', 'N/A', 'N/A', '3/14/2008', 'April / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (61, 2004, 104, 'Deposit', 343, 111461, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (62, 2004, 104, 'Deposit', 234, 111695, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (63, 2004, 104, 'Withdraw', 234, 111461, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (64, 2002, 102, 'Withdraw', 121, 77155.22, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (65, 2003, 103, 'Deposit', 121, 75882, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (66, 2002, 102, 'Deposit', 121, 77276.22, 'CHEQUE', '211111', 'HDFC', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (67, 2007, 107, 'Withdraw', 45675, 534324, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (68, 2007, 107, 'Withdraw', 367, 533957, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (69, 2002, 102, 'Withdraw', 13, 77263.22, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (70, 2004, 104, 'Withdraw', 343, 111118, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (71, 2005, 105, 'Withdraw', 334, 154838, 'N/A', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (72, 2002, 102, 'Deposit', 123, 77386.22, 'CASH', 'N/A', 'N/A', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (73, 2003, 103, 'Deposit', 23, 75905, 'CHEQUE', '232323', 'SBI', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (74, 2005, 105, 'Deposit', 23345, 178183, 'CHEQUE', '123444', 'HDFC', '3/14/2008', NULL);
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (75, 2007, 107, 'Interest', 10679.14, 544636.14, 'N/A', 'N/A', 'N/A', '3/14/2008', 'February / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (76, 2007, 107, 'Interest', 10679.14, 544636.14, 'N/A', 'N/A', 'N/A', '3/14/2008', 'April / 2008');
INSERT INTO [tbltransaction] ([TransactionID], [CustomerID], [AccountNo], [transactionType], [Amount], [Balance], [Mode], [ChequeNo], [BankName], [Date], [Month]) VALUES (77, 2005, 105, 'Withdraw', 20, 178163, 'N/A', 'N/A', 'N/A', '3/16/2008', NULL);

-- 77 row(s) in [tbltransaction]

