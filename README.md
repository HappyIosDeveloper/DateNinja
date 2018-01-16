# DateNinja
This is a Swift date convertor to convert any date string with any format to readable native swift date.

Usage:


let validDate = "2020-01-01T10:10:10.45323".toDateNinja() // 2020-01-01 10:10:10

let validDate = "2020-01-01T10:10:10.453".toDateNinja() // 2020-01-01 10:10:10

let validDate = "2020-01-01T10:10:10.45".toDateNinja() // 2020-01-01 10:10:10

let validDate = "2020-01-01T10:10:10 +04:35".toDateNinja() // 2020-01-01 10:10:10


// reset time(GMT):

let validDate = "2020-01-01T10:10:10.453".toDateNinja(true) // 2020-01-01 00:00:00

