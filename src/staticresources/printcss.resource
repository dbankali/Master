/* This style definition applies for PDF conversion
   and allows for specific formatting within that context */
@page {
	
	/* Landscape orientation */
	size:landscape;
	
	/* Put page numbers in the top right corner of each
	   page in the pdf document. */
	@top-right {
		content: "Page " counter(page);
	}
}

.title {
	font-size:24px;
	font-weight:bold;
	display:block;
}

.caseDetail {
	font-weight:bold;
	font-size:18px;
}

.month {
    border-bottom: 2px solid #000;
	font-size:18px;
}
    
.day {
	margin-left:3em;
	margin-top: 1em;
	border-bottom: 1px solid #000;
	font-size:14px;
}

.items {
	padding-left:5em;
	
	/* Specify preference to not break a page at 
		any element with this style. */
	page-break-before: avoid;
}

.time {
	white-space:nowrap;
}

