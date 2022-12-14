var college = {
  "Government College Daman": {
    "polyPlotLinks": [
      [20.41392495295493, 72.86237189934553],
      [20.413497186401866, 72.86260596657408],
      [20.41353557575646, 72.86279907203762],
      [20.413974310557645, 72.86267033506192],
      // [20.412230332330147, 72.8618393964006],
      // [],
    ],
    "HoI": "Dr. S. Kumar",
    "College_Type": "ARTS, COMMERCE AND SCIENCE",
    "Affliated_To": "Veer Narmad South Gujarat University",
    "Email": "pplgovt-dmn-dd@nic.in",
    "Location_Type": "Rural",
    "Established_Year": "1966",
    "Number of Teaching Staff": "39",
    "Depts": [
      {
        "id": 1,
        "Name": "Department of Economics",
        "HoD": "Dr. S. Kumar",
        "Associate Professor": [
          {
            "Name": "Smt. Daksha B. Patel",
            "Appointment Type": "Regular",
          },
          {
            "Name": "Dr. Satyabhama Tripathy",
            "Appointment Type": "Regular",
          },
          {
            "Name": "Dr. S. Kumar",
            "Appointment Type": "Regular",
          }
        ],
        "Assistant Professor (STC)": [
          {
            "Name": "Mr. Rahul Kumar",
            "Appointment Type": "Contract",
          },
          {
            "Name": "Mr. Gagan Shekhar",
            "Appointment Type": "Contract",
          },
        ],
      },
      {
        "id": 2,
        "Name": "Department of Botany",
        "HoD": "Dr. Prashant Pant",
      },
      {
        "id": 3,
        "Name": "Department of Chemistry",
        "HoD": "Dr. Satish Kumar Singh",
      },
      {
        "id": 4,
        "Name": "Department of Physics",
        "HoD": "Dr. Kaushal K. Thakkar",
      },
      {
        "id": 5,
        "Name": "Department of Mathematics",
        "HoD": "Dr. Bhatoa Joginder Singh",
      },
      {
        "id": 6,
        "Name": "Department of Zoology",
        "HoD": "Dr. B. J. Koppar",
      },
      {
        "id": 7,
        "Name": "Department of English",
        "HoD": "Mrs. Kathika V P",
      },
      {
        "id": 8,
        "Name": "Department of Hindi",
        "HoD": "Dr. Pukhraj Jangid",
      },
      {
        "id": 9,
        "Name": "Department of Psychology",
        "HoD": "Muhammed Sha",
      },
      {
        "id": 10,
        "Name": "Department of Gujrati",
        "HoD": "Dr. Bhavesh Vala",
      },
      {
        "id": 11,
        "Name": "Department of Sanskrit",
        "HoD": "Dr. Pankaj Dhanraj Jaje",
      },
      {
        "id": 12,
        "Name": "Department of Sociology",
        "HoD": "Neha Mishra",
      },
      {
        "id": 13,
        "Name": "Department of Commerce",
        "HoD": "Dr. D.C Agrawal",
      },
      {
        "id": 14,
        "Name": "General Department",
        "HoD": "",
      }
    ],
  },
  "Government Engineering College, Daman": {},
  "Dr. A.P.J. Abdul Kalam Government College, Silvassa": {},
  "Government Polytechnic College, Daman": {},
};
var dept = {};

List<String> collegeNames = [
  "Government College, Diu",
  "Government College, Daman",
  "APJ Abdul Kalaam, Silvassa",
  "Government Polytechnic, Daman",
  "Government Polytechnic, Diu",
  "Government Polytechnic, Silvassa",
  "Government Engineering College, Daman",
];

List<Map<String, dynamic>> intake = [
  // {
  //   "name": "total",
  //   "total": 8610,
  //   "annual": 4901,
  // },
  {
    "name": "Government College, Diu",
    "total": 775,
    "annual": 336,
  },
  {
    "name": "Government College, Daman",
    "total": 1431,
    "annual": 698,
  },
  {
    "name": "APJ Abdul Kalaam, Silvassa",
    "total": 1784,
    "annual": 820,
  },
  {
    "name": "Government Polytechnic, Daman",
    "total": 1027,
    "annual": 420,
  },
  {
    "name": "Government Polytechnic, Diu",
    "total": 300,
    "annual": 216,
  },
  {
    "name": "Government Polytechnic, Silvassa",
    "total": 570,
    "annual": 390,
  },
  {
    "name": "Government Engineering College, Daman",
    "total": 792,
    "annual": 330,
  },
];

const List<Map<String, dynamic>> gpi = [
  {
    "name": "Government College, Diu",
    "boys": 415,
    "girls": 360,
    "total": 775,
  },
  {
    "name": "Government College, Daman",
    "boys": 491,
    "girls": 940,
    "total": 1431,
  },
  {
    "name": "APJ Abdul Kalaam, Silvassa",
    "boys": 723,
    "girls": 1061,
    "total": 1784,
  },
  {
    "name": "Government Polytechnic, Daman",
    "boys": 807,
    "girls": 220,
    "total": 1027,
  },
  {
    "name": "Government Polytechnic, Diu",
    "boys": 288,
    "girls": 12,
    "total": 300,
  },
  {
    "name": "Government Polytechnic, Silvassa",
    "boys": 456,
    "girls": 114,
    "total": 570,
  },
  {
    "name": "Government Engineering College, Daman",
    "boys": 662,
    "girls": 130,
    "total": 792,
  },
  {
    "name": "IIIT, Diu",
    "boys": 131,
    "girls": 14,
    "total": 145,
  },
];
