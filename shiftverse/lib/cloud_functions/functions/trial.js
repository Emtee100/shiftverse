const moment = require("moment");

let today = moment("02/04/2024","MM/DD/YYYY").startOf("day");
//let yesterday = moment().subtract(1, "days");
//let formattedDate = today.format("MM/DD/YYYY");
// if(today.isAfter(yesterday)){
// console.log(true);
// }else{
// console.log(false);
// }
console.log(today);