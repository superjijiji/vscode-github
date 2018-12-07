// below 3 functions are from /transform/edge/javascript/CheckDateInput.js in edge-eod-main
function checkDateInput(dateString, wrongDateFormatMsg) {
  
	s = new String(dateString);
  
	if (s.length == 0)
		return true;

	if (s.length == 10 &&  // correct length
		s.match(/\d{4}-\d{2}-\d{2}/i) != null) // correct format
	{
	    // get year, month and day as numbers
	    year  = new Number(s.substring(0, 4));
	    month = new Number(s.substring(5, 7));
	    day   = new Number(s.substring(8, 10));
	
	    if (year != NaN && month != NaN && day != NaN && // if they are numbers
	        month > 0 && month < 13 ) // and month number is correct
	    {
			// check number of days in particular month:
			var ndays = 31; //   31 days a month
	
			switch(month)
			{
				// 30 days a month
		        case 4: // April
		        case 6: // June
		        case 9: // September
		        case 11: // November
		          ndays = 30;
		          break;
		
		        case 2: // February
		          if (year % 4 != 0 || (year % 100 == 0 && year % 400 != 0))
		            ndays = 28;
		          else
		            ndays = 29;
		          break;
		        default:
		          ndays = 31;
			}
	
			if (day >= 0 && day <= ndays)
	        return true;
	    }
	}

	alert(wrongDateFormatMsg);
	return false;
}

function checkDateInputIfOld(aString, current_date, oldDateMsg, wrongDateFormatMsg) {
	
	if (checkDateInput(aString, wrongDateFormatMsg) == true)
	{
		s = new String(aString);

		if (s.length != 0 && s < current_date)
	    {
			alert(oldDateMsg);
			return false;
	    }
	
	    return true;
	}

	return false;
}

function checkTimeInput(timeString, wrongTimeFormatMsg) {
	
	s = new String(timeString);
	
	if (s.length == 8 &&  // correct length
		s.match(/\d{2}:\d{2}:\d{2}/i) != null)	// correct format
	{
	    // get hour and minute as numbers
	    hour  = new Number(s.substring(0, 2));
	    minute = new Number(s.substring(3, 5));
	
	    if (hour != NaN && minute != NaN && // if they are numbers
	        hour >= 0 && hour < 24 && minute >= 0 && minute < 60) // and hour number is correct
	    	return true;
	    else
		{
			alert(wrongTimeFormatMsg);
			return false;	
		}
	}

	alert(wrongTimeFormatMsg);
	return false;
}