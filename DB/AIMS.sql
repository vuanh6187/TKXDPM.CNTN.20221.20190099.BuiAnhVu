--
-- Cấu trúc bảng cho bảng `book`
--

CREATE TABLE `book` (
  `id` int(11) NOT NULL,
  `author` varchar(45) NOT NULL,
  `coverType` varchar(45) NOT NULL,
  `publisher` varchar(45) NOT NULL,
  `publishDate` datetime NOT NULL,
  `numOfPages` int(11) NOT NULL,
  `language` varchar(45) NOT NULL,
  `bookCategory` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cd`
--

CREATE TABLE `cd` (
  `id` int(11) NOT NULL,
  `artist` varchar(45) NOT NULL,
  `recordLabel` varchar(45) NOT NULL,
  `musicType` varchar(45) NOT NULL,
  `releasedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `deliveryinfo`
--

CREATE TABLE `deliveryinfo` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `province` varchar(45) DEFAULT NULL,
  `instructions` varchar(200) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `Order_id` int(11) NOT NULL,
  `Order_DeliveryInfoId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dvd`
--

CREATE TABLE `dvd` (
  `id` int(11) NOT NULL,
  `discType` varchar(45) NOT NULL,
  `director` varchar(45) NOT NULL,
  `runtime` int(11) NOT NULL,
  `studio` varchar(45) NOT NULL,
  `subtitle` varchar(45) NOT NULL,
  `releasedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `totalAmount` int(11) NOT NULL,
  `orderId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `media`
--

CREATE TABLE `media` (
  `id` int(11) NOT NULL,
  `category` varchar(45) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `title` varchar(45) NOT NULL,
  `value` int(11) NOT NULL,
  `imageUrl` varchar(45) NOT NULL,
  `DVD_id` int(11) DEFAULT NULL,
  `CD_id` int(11) NOT NULL,
  `BOOK_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `shippingFees` varchar(45) NOT NULL,
  `DeliveryInfoId` int(11) NOT NULL,
  `Invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ordermedia`
--

CREATE TABLE `ordermedia` (
  `orderID` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `media_Id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `paymenttransaction`
--

CREATE TABLE `paymenttransaction` (
  `id` int(11) NOT NULL,
  `createAt` datetime NOT NULL,
  `content` varchar(45) NOT NULL,
  `method` varchar(45) DEFAULT NULL,
  `card_Id` int(11) NOT NULL,
  `invoice_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `cd`
--
ALTER TABLE `cd`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `deliveryinfo`
--
ALTER TABLE `deliveryinfo`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `dvd`
--
ALTER TABLE `dvd`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orderId` (`orderId`);

--
-- Chỉ mục cho bảng `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `CD_id` (`CD_id`),
  ADD UNIQUE KEY `BOOK_id` (`BOOK_id`),
  ADD UNIQUE KEY `DVD_id` (`DVD_id`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Invoice_id` (`Invoice_id`),
  ADD UNIQUE KEY `DeliveryInfoId` (`DeliveryInfoId`);

--
-- Chỉ mục cho bảng `ordermedia`
--
ALTER TABLE `ordermedia`
  ADD PRIMARY KEY (`orderID`,`media_Id`) USING BTREE,
  ADD KEY `media_Id` (`media_Id`);

--
-- Chỉ mục cho bảng `paymenttransaction`
--
ALTER TABLE `paymenttransaction`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_Id` (`invoice_Id`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`id`) REFERENCES `media` (`BOOK_id`);

--
-- Các ràng buộc cho bảng `cd`
--
ALTER TABLE `cd`
  ADD CONSTRAINT `cd_ibfk_1` FOREIGN KEY (`id`) REFERENCES `media` (`CD_id`);

--
-- Các ràng buộc cho bảng `dvd`
--
ALTER TABLE `dvd`
  ADD CONSTRAINT `dvd_ibfk_1` FOREIGN KEY (`id`) REFERENCES `media` (`DVD_id`);

--
-- Các ràng buộc cho bảng `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `order` (`id`);

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`DeliveryInfoId`) REFERENCES `deliveryinfo` (`id`),
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`id`) REFERENCES `ordermedia` (`orderID`);

--
-- Các ràng buộc cho bảng `ordermedia`
--
ALTER TABLE `ordermedia`
  ADD CONSTRAINT `ordermedia_ibfk_1` FOREIGN KEY (`media_Id`) REFERENCES `media` (`id`);

--
-- Các ràng buộc cho bảng `paymenttransaction`
--
ALTER TABLE `paymenttransaction`
  ADD CONSTRAINT `paymenttransaction_ibfk_1` FOREIGN KEY (`invoice_Id`) REFERENCES `invoice` (`id`);
COMMIT;
