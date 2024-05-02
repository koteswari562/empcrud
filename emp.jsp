<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Form Layout</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        padding: 20px;
    }
    .hii{
    width:60%;}
    h3{
    text-align:center;
    }

	.container {
		display: grid;
		grid-template-columns: auto 1fr auto 1fr; /* Two pairs of label + text field per row */
		grid-gap: 20px;
	}

	.label {
		text-align: right;
		padding-right: 40px;
		align-self: center; /* Align label vertically centered */
	}

	.text-field {
		padding: 5px;
		width: 60%; /* Text field fills the entire cell */
		box-sizing: border-box;
		border: 1px solid #ccc;
		border-radius: 5px;
	}
	.button-row {
		display: grid;
		grid-template-columns: repeat(4, 1fr); /* Four columns for buttons */
		grid-gap: 20px;
		margin-top: 20px;
	}

	.button {
	width:80%;
		padding: 10px;
		background-color: #0e63e3;
		color: white;
		border: none;
		border-radius: 5px;
		cursor: pointer;
	}

	.button:hover {
		background-color: #0056b3;
	}
	/* Basic styling for the table */
.table {
    width: 100%;
    border-collapse: collapse; 
    margin-top: 20px;
    border:1px solid black;
}

.table th {
    padding: 10px;
    text-align: left;
}
.table tr {
    border-bottom: 1px solid black; 
}

/* Styling for table cells (td) */
.table td {
    padding: 10px;
}

</style>
</head>
<body>
<div class="hii">
	<h3>Employee</h3>

	<div class="container">
			<label class="label" for="input1">EmpNo:</label>
			<input class="text-field" type="text" id="input1">
			<label class="label" for="input2">Name:</label>
			<input class="text-field" type="text" id="input2">
			<label class="label" for="input3">Job:</label>
			<input class="text-field" type="text" id="input3">
			<label class="label" for="input4">Salary:</label>
			<input class="text-field" type="text" id="input4">
			<label class="label" for="input4">DeptNo:</label>
			<input class="text-field" type="text" id="input4">
			<label class="label" for="input4">Hiredate:</label>
			<input class="text-field" type="text" id="input4">
		
	</div>
	<div class="button-row">
			<button class="button" id="first">First</button>
			<button class="button" id="next">Next</button>
			<button class="button" id="previous">previous</button>
			<button class="button" id="last">Last</button>
			<button class="button" id="add">Add</button>
			<button class="button" id="save">Save</button>
			<button class="button" id="clear">Clear</button>
			<button class="button" id="delete">Delete</button>
		</div>
		<div class="table-container">
		</div>
	</div>
</body>
<script>

$(document).ready(function() {
    $.ajax({
        url: 'EmpDisplayServlet',
        method: 'POST', 
        success: function(data) {
            console.log("Data received:", data);
            var table = $("<table>").addClass("table product-table");

            var tableHeaderRow = $("<tr>");
            tableHeaderRow.append($("<th>").text("EmpNo"));
            tableHeaderRow.append($("<th>").text("EmpName"));
            tableHeaderRow.append($("<th>").text("Job"));
            tableHeaderRow.append($("<th>").text("Salary"));
            tableHeaderRow.append($("<th>"));
           table.append(tableHeaderRow);
            
            $.each(data, function(index, employee) {
                var tableRow = $("<tr>");
                tableRow.append($("<td>").text(employee.empNo));
                tableRow.append($("<td>").text(employee.empName));
                tableRow.append($("<td>").text(employee.job));
                tableRow.append($("<td>").text(employee.salary));
                var button = $("<button>").text("Edit").attr('id',employee.empNo).addClass("edit");
				tableRow.append(button);
                table.append(tableRow);
            });
            $(".table-container").empty().append(table);
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
           
        }
    });
});

$(document).ready(function() {
    $(document).on('click', '#first', function() {
    	var rowCount = $('table tr').length;
    	var row = $('table tr:eq(1)');
        if (row.length > 0) {
            var rowdata = [];
            row.find('td').each(function() {
                var cellValue = $(this).text();
                rowdata.push(cellValue);
            });
        } else {
            console.log("row not found.");
        }
        $('#input1').val(rowdata[0]);
        $('#input2').val(rowdata[1]);
        $('#input3').val(rowdata[2]);
        $('#input4').val(rowdata[3]);


    });
    $(document).on('click', '#last', function() {
    	var rowCount = $('table tr').length-1;
    	console.log(rowCount);
    	var row = $('table tr:eq('+rowCount+')');
        if (row.length > 0) {
            var rowdata = [];
            row.find('td').each(function() {
                var cellValue = $(this).text();
                rowdata.push(cellValue);
            });
        } else {
            console.log("row not found.");
        }
        $('#input1').val(rowdata[0]);
        $('#input2').val(rowdata[1]);
        $('#input3').val(rowdata[2]);
        $('#input4').val(rowdata[3]);


    });
    $(document).on('click', '#next', function() {
    	var rowCount = $('table tr').length;
    	var empno=$('#input1').val();
    	console.log(empno);
    	var empnos=[];
    	var ind;
    	    $('table tr').each(function() {
    	        var firstCell = $(this).find('td:first');
    	        var firstCellValue = firstCell.text().trim();
    	        empnos.push(firstCellValue);
    	        if(firstCellValue==empno){
    	        	ind=empnos.length;
    	        }
    	    });
    	var row = $('table tr:eq('+ind+')');
        if (row.length > 0) {
            var rowdata = [];
            row.find('td').each(function() {
                var cellValue = $(this).text();
                rowdata.push(cellValue);
            });
        } else {
            console.log("row not found.");
        }
        $('#input1').val(rowdata[0]);
        $('#input2').val(rowdata[1]);
        $('#input3').val(rowdata[2]);
        $('#input4').val(rowdata[3]);

    });
    $(document).on('click', '#previous', function() {
    	var rowCount = $('table tr').length;
    	var empno=$('#input1').val();
    	var empnos=[];
    	var ind;
    	    $('table tr').each(function() {
    	        var firstCell = $(this).find('td:first');
    	        var firstCellValue = firstCell.text().trim();
    	        empnos.push(firstCellValue);
    	        if(firstCellValue==empno){
    	        	ind=empnos.length-2;
    	        }
    	    });
    	console.log(ind);
    	if(ind>0){
    		var row = $('table tr:eq('+ind+')');
        if (row.length > 0 && ind>0) {
            var rowdata = [];
            row.find('td').each(function() {
                var cellValue = $(this).text();
                rowdata.push(cellValue);
            });
        } else {
            console.log("row not found.");
        }
    	}
        $('#input1').val(rowdata[0]);
        $('#input2').val(rowdata[1]);
        $('#input3').val(rowdata[2]);
        $('#input4').val(rowdata[3]);

    });
    $(document).on('click','#clear',function(){
        $('#input1').val("");
        $('#input2').val("");
        $('#input3').val("");
        $('#input4').val("");
    })
})
$(document).on('click','#add',function(){
	var empno=parseInt($('#input1').val());
	var ename=$('#input2').val();
	var job=$('#input3').val();
	var salary=parseInt($('#input4').val());
	$.ajax({
        url: 'AddServlet',
        method: 'POST', 
        data: {eno:empno,ename:ename,ejob:job,esalary:salary},
        success: function(data) {
			alert('Employee Added!!');
			$.ajax({
		        url: 'EmpDisplayServlet',
		        method: 'POST', 
		        success: function(data) {
		            console.log("Data received:", data);
		            var table = $("<table>").addClass("table product-table");

		            var tableHeaderRow = $("<tr>");
		            tableHeaderRow.append($("<th>").text("EmpNo"));
		            tableHeaderRow.append($("<th>").text("EmpName"));
		            tableHeaderRow.append($("<th>").text("Job"));
		            tableHeaderRow.append($("<th>").text("Salary"));
		            tableHeaderRow.append($("<th>"));
		            table.append(tableHeaderRow);
		            
		            $.each(data, function(index, employee) {
		                var tableRow = $("<tr>");
		                tableRow.append($("<td>").text(employee.empNo));
		                tableRow.append($("<td>").text(employee.empName));
		                tableRow.append($("<td>").text(employee.job));
		                tableRow.append($("<td>").text(employee.salary));
		                var button = $("<button>").text("Edit").attr('id',employee.empNo).addClass("edit");
						tableRow.append(button);
		                table.append(tableRow);
		            });
		            $(".table-container").empty().append(table);
		        },
		        error: function(xhr, status, error) {
		            console.error('Error:', error);
		           
		        }
		    });
			
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
           
        }
    });
})
$(document).on('click',".edit",function(){
	var rowCount = $('table tr').length;
	var empno=$(this).attr('id');
	console.log(empno);
	var empnos=[];
	var ind;
	    $('table tr').each(function() {
	        var firstCell = $(this).find('td:first');
	        var firstCellValue = firstCell.text().trim();
	        empnos.push(firstCellValue);
	        if(firstCellValue==empno){
	        	ind=empnos.length-1;
	        }
	    });
	var row = $('table tr:eq('+ind+')');
    if (row.length > 0) {
        var rowdata = [];
        row.find('td').each(function() {
            var cellValue = $(this).text();
            rowdata.push(cellValue);
        });
    } else {
        console.log("row not found.");
    }
    $('#input1').val(rowdata[0]);
    $('#input2').val(rowdata[1]);
    $('#input3').val(rowdata[2]);
    $('#input4').val(rowdata[3]);
	
});
$(document).on('click','#save',function(){
	var empno=parseInt($('#input1').val());
	var ename=$('#input2').val();
	var job=$('#input3').val();
	var salary=parseInt($('#input4').val());
	$.ajax({
        url: 'SaveServlet',
        method: 'POST', 
        data: {eno:empno,ename:ename,ejob:job,esalary:salary},
        success: function(data) {
			alert('Updated!!');
			$.ajax({
		        url: 'EmpDisplayServlet',
		        method: 'POST', 
		        success: function(data) {
		            console.log("Data received:", data);
		            var table = $("<table>").addClass("table product-table");

		            var tableHeaderRow = $("<tr>");
		            tableHeaderRow.append($("<th>").text("EmpNo"));
		            tableHeaderRow.append($("<th>").text("EmpName"));
		            tableHeaderRow.append($("<th>").text("Job"));
		            tableHeaderRow.append($("<th>").text("Salary"));
		            tableHeaderRow.append($("<th>"));
		            table.append(tableHeaderRow);
		            
		            $.each(data, function(index, employee) {
		                var tableRow = $("<tr>");
		                tableRow.append($("<td>").text(employee.empNo));
		                tableRow.append($("<td>").text(employee.empName));
		                tableRow.append($("<td>").text(employee.job));
		                tableRow.append($("<td>").text(employee.salary));
		                var button = $("<button>").text("Edit").attr('id',employee.empNo).addClass("edit");
						tableRow.append(button);
		                table.append(tableRow);
		            });
		            $(".table-container").empty().append(table);
		        },
		        error: function(xhr, status, error) {
		            console.error('Error:', error);
		           
		        }
		    });
			
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
           
        }
    });
})
$(document).on('click','#delete',function(){
	var empno=parseInt($('#input1').val());
	$.ajax({
        url: 'DeleteServlet',
        method: 'POST', 
        data: {eno:empno},
        success: function(data) {
			alert('Deleted!!');
			$.ajax({
		        url: 'EmpDisplayServlet',
		        method: 'POST', 
		        success: function(data) {
		            console.log("Data received:", data);
		            var table = $("<table>").addClass("table product-table");

		            var tableHeaderRow = $("<tr>");
		            tableHeaderRow.append($("<th>").text("EmpNo"));
		            tableHeaderRow.append($("<th>").text("EmpName"));
		            tableHeaderRow.append($("<th>").text("Job"));
		            tableHeaderRow.append($("<th>").text("Salary"));
		            tableHeaderRow.append($("<th>"));
		            table.append(tableHeaderRow);
		            
		            $.each(data, function(index, employee) {
		                var tableRow = $("<tr>");
		                tableRow.append($("<td>").text(employee.empNo));
		                tableRow.append($("<td>").text(employee.empName));
		                tableRow.append($("<td>").text(employee.job));
		                tableRow.append($("<td>").text(employee.salary));
		                var button = $("<button>").text("Edit").attr('id',employee.empNo).addClass("edit");
						tableRow.append(button);
		                table.append(tableRow);
		            });
		            $(".table-container").empty().append(table);
		        },
		        error: function(xhr, status, error) {
		            console.error('Error:', error);
		           
		        }
		    });
			
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
           
        }
    });
})
</script>
</html>
