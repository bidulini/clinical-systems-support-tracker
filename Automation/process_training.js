const fs = require("fs");

const data=JSON.parse(
	fs.readFileSync("api_training_data.json","utf8")
);

const validEmployees= [
	"EMP001",
	"EMP002",
	"EMP003",
	"EMP004"
];

const validCourses = [
    "CRS001",
    "CRS002",
    "CRS003",
    "CRS004",
    "CRS005",
    "CRS006",
    "CRS007",
    "CRS008"
];


function validateRecord(record) {
	const validEmployee = validEmployees.includes(record.employeeId);

if(!validEmployee) {
return {
	status:"FAIL",
	reason:"Invalid Employee ID"
};
}

if(!validEmployee) {
	return {
		status:"FAIL",
		reason:"Invalid Employee ID"
	};
}

const validCourse=validCourses.includes(record.courseCode);

if(!validCourse) {
	return {
		status:"FAIL",
	reason:"Invalid Course ID" }; 
}

if (
record.trainingStatus==="Completed" && record.completedAt===null)
{return {status:"FAIL",
reason:"Completed Without Date" }; 
}
return {status:"PASS",
reason:"Valid" }; }

const acceptedRecords=[];
const rejectedRecords=[];

data.records.forEach(record => {
const result = validateRecord(record);

const processedRecord={
	...record,
	validationStatus:result.status,
validationReason:result.reason};

if(result.status==="PASS"){
acceptedRecords.push(processedRecord);}
else {
rejectedRecords.push(processedRecord);}
});

console.log("Accepted: ",acceptedRecords);
console.log("Rejected: ",rejectedRecords);


fs.writeFileSync(
"accepted_training.json",
JSON.stringify(acceptedRecords,null,2) );

fs.writeFileSync(
"rejected_training.json",
JSON.stringify(rejectedRecords,null,2) );

console.log("Output files created succesfully.");

const totalRecords = data.records.length;
const acceptedCount=acceptedRecords.length;
const rejectedCount=rejectedRecords.length;

console.log("\nProcessing Summary...");
console.log("\n.....................");
console.log("\nTotal records: ", totalRecords);
console.log("\nAccepted: ", acceptedCount);
console.log("\nRejected: ", rejectedCount);

const rejectionReasons = {};

rejectedRecords.forEach (record=> {
	const reason=record.validationReason;
	
	if(rejectionReasons[reason]) {
		rejectionReasons[reason]++;
	}
	else {
		rejectionReasons[reason]=1;
	}
});

console.log("\nRejection Reasons");
console.log("-------------------");
console.log(rejectionReasons);

const summary = {
	totalRecords: totalRecords,
	accepted: acceptedCount,
	rejected: rejectedCount,
rejectionReasons: rejectionReasons };

fs.writeFileSync(
"processing_summary.json",
JSON.stringify(summary,null,2)
);

console.log("Processing summary saved.");





