/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/7/6 13:22:04                            */
/*==============================================================*/


drop table if exists AdminInfo;

drop table if exists CouponInfo;

drop table if exists DeliveryAddr;

drop table if exists FullReductionScheme;

drop table if exists OrderDetail;

drop table if exists OrderForm;

drop table if exists ProductCategory;

drop table if exists ProductDetails;

drop table if exists RiderDeliverOrder;

drop table if exists RiderInfo;

drop table if exists ShopInfo;

drop table if exists UserHoldCoupons;

drop table if exists UserInfo;

drop table if exists UserOrderCount;

drop table if exists evaluate;

/*==============================================================*/
/* Table: AdminInfo                                             */
/*==============================================================*/
create table AdminInfo
(
   admin_id             int not null auto_increment,
   admin_name           varchar(20) not null,
   admin_pwd            varchar(15) not null,
   admin_logout_date    date,
   primary key (admin_id)
);

/*==============================================================*/
/* Table: CouponInfo                                            */
/*==============================================================*/
create table CouponInfo
(
   coupon_id            int not null auto_increment,
   shop_id              int,
   coupon_amount        float(8,2) not null,
   coupon_ordered_number_requirement int not null,
   coupon_start_date    timestamp,
   coupon_end_date      timestamp,
   coupon_delete_time   timestamp,
   primary key (coupon_id)
);

/*==============================================================*/
/* Table: DeliveryAddr                                          */
/*==============================================================*/
create table DeliveryAddr
(
   addr_id              int not null auto_increment,
   user_id              int,
   addr_province        varchar(30) not null,
   addr_city            varchar(30) not null,
   addr_district        varchar(30) not null,
   addr_detailed_addr   varchar(60) not null,
   addr_contact_person  varchar(20) not null,
   addr_contact_phone   varchar(15) not null,
   primary key (addr_id)
);

/*==============================================================*/
/* Table: FullReductionScheme                                   */
/*==============================================================*/
create table FullReductionScheme
(
   fullreduction_id     int not null auto_increment,
   shop_id              int,
   fullreduction_amount float(8,2) not null,
   fullreduction_discounted_price float(8,2) not null,
   fullreduction_can_superimposed_with_coupons bool not null,
   fullreduction_delete_time timestamp,
   primary key (fullreduction_id)
);

/*==============================================================*/
/* Table: OrderDetail                                           */
/*==============================================================*/
create table OrderDetail
(
   order_id             int not null,
   product_id           int not null,
   amount               int not null,
   price                float(8,2) not null,
   single_product_discount_amount float(8,2),
   primary key (order_id, product_id)
);

/*==============================================================*/
/* Table: OrderForm                                             */
/*==============================================================*/
create table OrderForm
(
   order_id             int not null auto_increment,
   shop_id              int,
   fullreduction_id     int,
   addr_id              int,
   user_id              int,
   coupon_id            int,
   order_original_amount float(8,2) not null,
   order_actual_amount  float(8,2) not null,
   order_time           timestamp not null,
   order_request_delivery_time timestamp not null,
   order_status         varchar(10) not null,
   order_delete_time    timestamp,
   primary key (order_id)
);

/*==============================================================*/
/* Table: ProductCategory                                       */
/*==============================================================*/
create table ProductCategory
(
   productcategory_id   int not null auto_increment,
   shop_id              int,
   productcategory_column_name varchar(30) not null,
   productcategory_delete_time timestamp,
   primary key (productcategory_id)
);

/*==============================================================*/
/* Table: ProductDetails                                        */
/*==============================================================*/
create table ProductDetails
(
   product_id           int not null auto_increment,
   productcategory_id   int,
   shop_id              int,
   product_name         varchar(30) not null,
   product_price        float(8,2) not null,
   product_discounted_price float(8,2),
   product_delete_time  timestamp,
   primary key (product_id)
);

/*==============================================================*/
/* Table: RiderDeliverOrder                                     */
/*==============================================================*/
create table RiderDeliverOrder
(
   order_id             int not null,
   rider_id             int not null,
   deliver_time         timestamp not null,
   deliver_user_rate    int,
   deliver_single_income float(8,2) not null,
   primary key (order_id, rider_id)
);

/*==============================================================*/
/* Table: RiderInfo                                             */
/*==============================================================*/
create table RiderInfo
(
   rider_id             int not null auto_increment,
   rider_name           varchar(10) not null,
   rider_pwd            varchar(15) not null,
   rider_entry_date     date not null,
   rider_identity       int not null,
   rider_total_income   float(8,2),
   rider_logout_date    date,
   primary key (rider_id)
);

/*==============================================================*/
/* Table: ShopInfo                                              */
/*==============================================================*/
create table ShopInfo
(
   shop_id              int not null auto_increment,
   shop_name            varchar(30) not null,
   shop_pwd             varchar(30) not null,
   shop_level           int not null,
   shop_per_capita_consumption float(8,2),
   shop_total_sales     float(8,2),
   shop_logout_time     date,
   primary key (shop_id)
);

/*==============================================================*/
/* Table: UserHoldCoupons                                       */
/*==============================================================*/
create table UserHoldCoupons
(
   user_id              int not null,
   coupon_id            int not null,
   amount               int not null,
   ddl                  date,
   primary key (user_id, coupon_id)
);

/*==============================================================*/
/* Table: UserInfo                                              */
/*==============================================================*/
create table UserInfo
(
   user_id              int not null auto_increment,
   user_name            varchar(10) not null,
   user_gender          bool,
   user_pwd             varchar(15) not null,
   user_phone_number    varchar(15) not null,
   user_mail            varchar(30),
   user_city            varchar(30),
   user_registration_time date not null,
   user_is_vip          bool not null,
   user_vip_ddl         date,
   user_logout_time     date,
   primary key (user_id)
);

/*==============================================================*/
/* Table: UserOrderCount                                        */
/*==============================================================*/
create table UserOrderCount
(
   user_id              int not null,
   shop_id              int not null,
   order_count          int,
   primary key (user_id, shop_id)
);

/*==============================================================*/
/* Table: evaluate                                              */
/*==============================================================*/
create table evaluate
(
   user_id              int not null,
   order_id             int not null,
   evaluate_content     varchar(500) not null,
   evaluate_date        timestamp not null,
   evaluate_score       int not null,
   evaluate_photo       longblob,
   evaluate_rider       bool,
   primary key (user_id, order_id)
);

alter table CouponInfo add constraint FK_CouponsBelongToShop foreign key (shop_id)
      references ShopInfo (shop_id) on delete restrict on update restrict;

alter table DeliveryAddr add constraint FK_AddrBelongtoUser foreign key (user_id)
      references UserInfo (user_id) on delete restrict on update restrict;

alter table FullReductionScheme add constraint FK_FullReductionSchemeMadebyShop foreign key (shop_id)
      references ShopInfo (shop_id) on delete restrict on update restrict;

alter table OrderDetail add constraint FK_OrderDetail foreign key (order_id)
      references OrderForm (order_id) on delete restrict on update restrict;

alter table OrderDetail add constraint FK_OrderDetail2 foreign key (product_id)
      references ProductDetails (product_id) on delete restrict on update restrict;

alter table OrderForm add constraint FK_CouponOnOrder foreign key (coupon_id)
      references CouponInfo (coupon_id) on delete restrict on update restrict;

alter table OrderForm add constraint FK_FullreductionOnOrder foreign key (fullreduction_id)
      references FullReductionScheme (fullreduction_id) on delete restrict on update restrict;

alter table OrderForm add constraint FK_OrderAddr foreign key (addr_id)
      references DeliveryAddr (addr_id) on delete restrict on update restrict;

alter table OrderForm add constraint FK_ShopisOrdered foreign key (shop_id)
      references ShopInfo (shop_id) on delete restrict on update restrict;

alter table OrderForm add constraint FK_UserOrder foreign key (user_id)
      references UserInfo (user_id) on delete restrict on update restrict;

alter table ProductCategory add constraint FK_CategoriesMadebyShop foreign key (shop_id)
      references ShopInfo (shop_id) on delete restrict on update restrict;

alter table ProductDetails add constraint FK_ProductsBelongToShop foreign key (shop_id)
      references ShopInfo (shop_id) on delete restrict on update restrict;

alter table ProductDetails add constraint FK_ProductsBelongtoCategory foreign key (productcategory_id)
      references ProductCategory (productcategory_id) on delete restrict on update restrict;

alter table RiderDeliverOrder add constraint FK_RiderDeliverOrder foreign key (order_id)
      references OrderForm (order_id) on delete restrict on update restrict;

alter table RiderDeliverOrder add constraint FK_RiderDeliverOrder2 foreign key (rider_id)
      references RiderInfo (rider_id) on delete restrict on update restrict;

alter table UserHoldCoupons add constraint FK_UserHoldCoupons foreign key (user_id)
      references UserInfo (user_id) on delete restrict on update restrict;

alter table UserHoldCoupons add constraint FK_UserHoldCoupons2 foreign key (coupon_id)
      references CouponInfo (coupon_id) on delete restrict on update restrict;

alter table UserOrderCount add constraint FK_UserOrderCount foreign key (user_id)
      references UserInfo (user_id) on delete restrict on update restrict;

alter table UserOrderCount add constraint FK_UserOrderCount2 foreign key (shop_id)
      references ShopInfo (shop_id) on delete restrict on update restrict;

alter table evaluate add constraint FK_evaluate foreign key (user_id)
      references UserInfo (user_id) on delete restrict on update restrict;

alter table evaluate add constraint FK_evaluate2 foreign key (order_id)
      references OrderForm (order_id) on delete restrict on update restrict;

