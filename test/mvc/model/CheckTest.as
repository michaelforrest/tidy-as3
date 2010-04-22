package test.mvc.model 
{
	import tidy.mvc.model.Check;
	import asunit.framework.TestCase;

	/**
	 * @author christian
	 */
	public class CheckTest extends TestCase 
	{
		public function CheckTest(testMethod : String = null)
		{
			super(testMethod);
		}
		
		public function  testNotNull () : void
		{
			var o : Object;
			try{
				Check.notNull(o, null);
				fail("notNull should throw error if source is both parameters are null");
			}catch(e : Error){}
			
			o =  {myProperty:null};
			try{
				Check.notNull(o, null);
				fail("notNull should throw error if required_fields are null");
			}catch(e : Error){}
			Check.notNull(o, []);
			try{
				Check.notNull(0, ["myProperty"]);
				fail("notNull should throw error if a required fields is null");
			}catch(e : Error){}
		}
	}
}
