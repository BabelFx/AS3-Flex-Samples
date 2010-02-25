package com.thunderbay.i18nDemo.model
{
	import mx.utils.StringUtil;
	
	public class StatesVO
	{
		static public function get full()			: XMLList {	 return _states.state;						}
		static public function get abbreviations()	: XMLList {  return (_states.state.@abbreviation);  	}
		static public function get names()  		: XMLList {  return (_states.state.@name);  			}
		
		static public function indexOf(state:String,isAbbreviation:Boolean=false):int {
			var all     : XMLList = isAbbreviation ? _states.state.@abbreviation : _states.state.@name;
			var results : int     = -1;
			 
			if (StringUtil.trim(state) != "") {
				for (var j:int=0; j<all.length(); j++) {
					var it:String = all[j];
					
					if (it == state) {
						results = j;
						break; 
					}
				}
			}
			
			return results;
		}
		

	static private var _states : XML = <states>
									  <state name="Alabama" abbreviation="AL" />
									  <state name="Alaska" abbreviation="AK" />
									  <state name="American Samoa" abbreviation="" /> 
									  <state name="Arizona" abbreviation="AZ" />
									  <state name="Arkansas" abbreviation="AR" />
									  <state name="California" abbreviation="CA" />
									  <state name="Colorado" abbreviation="CO" />
									  <state name="Connecticut" abbreviation="CT" />
									  <state name="Delaware" abbreviation="DE" />
									  <state name="District of Columbia" abbreviation="DC" />
									  <state name="Florida" abbreviation="FL" />
									  <state name="Georgia" abbreviation="GA" />
									  <state name="Hawaii" abbreviation="HI" />
									  <state name="Idaho" abbreviation="ID" />
									  <state name="Illinois" abbreviation="IL" />
									  <state name="Iowa" abbreviation="IA" />
									  <state name="Kansas" abbreviation="KS" />
									  <state name="Kentucky" abbreviation="KY" />
									  <state name="Louisiana" abbreviation="LA" />
									  <state name="Maine" abbreviation="ME" />
									  <state name="Maryland" abbreviation="MD" />
									  <state name="Massachussetts" abbreviation="MA" />
									  <state name="Michigan" abbreviation="MI" />
									  <state name="Minnesota" abbreviation="MN" />
									  <state name="Mississippi" abbreviation="MS" />
									  <state name="Missouri" abbreviation="MO" />
									  <state name="Montana" abbreviation="MT" />
									  <state name="Nebraska" abbreviation="NE" />
									  <state name="Nevada" abbreviation="NV" />
									  <state name="New Hampshire" abbreviation="NH" />
									  <state name="New Jersey" abbreviation="NJ" />
									  <state name="New Mexico" abbreviation="NM" />
									  <state name="New York" abbreviation="NY" />
									  <state name="North Carolina" abbreviation="NC" />
									  <state name="North Dakota" abbreviation="ND" />
									  <state name="Northern Marianas Islands" abbreviation="MP" />  
									  <state name="Ohio" abbreviation="OH" />
									  <state name="Oklahoma" abbreviation="OK" />
									  <state name="Oregon" abbreviation="OR" />
									  <state name="Pennsylvania" abbreviation="PA" />
									  <state name="Puerto Rico" abbreviation="" />  !!
									  <state name="Rhode Island" abbreviation="RI" />
									  <state name="South Carolina" abbreviation="SC" />
									  <state name="South Dakota" abbreviation="SD" />
									  <state name="Tennessee" abbreviation="TN" />
									  <state name="Texas" abbreviation="TX" />
									  <state name="Utah" abbreviation="UT" />
									  <state name="Vermont" abbreviation="VT" />
									  <state name="Virginia" abbreviation="VA" />
									  <state name="US Virgin Islands" abbreviation="VI" />  
									  <state name="Washington" abbreviation="WA" />
									  <state name="West Virgina" abbreviation="WV" />
									  <state name="Wisconsin" abbreviation="WI" />
									  <state name="Wyoming" abbreviation="WY" />
									</states>					
	}
}