enum BookingStatus { newOrder, booked, progress, ended, canceled, }

enum DropDownType { categories, users, masters }

enum ExtrasType { color, text, image }

enum ChairPosition { top, bottom, left, right }

enum CalendarType { day,threeDay, week }

enum UploadType {
  extras,
  brands,
  categories,
  shopsLogo,
  shopsBack,
  products,
  reviews,
  users,
  stocks,
  discounts,
}

enum OrderStatus {
  newOrder,
  accepted,
  ready,
  onAWay,
  delivered,
  canceled,
}


enum MasterStatus {
  newMaster,
  acceptedMaster,
  cancelledMaster,
  rejectedMaster,
}

enum ProductStatus { published, pending, unpublished }

enum CategoryStatus { published, pending, unpublished }

enum MinuteSlotSize {
  minutes5,
  minutes15,
  minutes30,
  minutes60,
}
enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
enum LineStyle {
  solid,
  dashed,
}
