public with sharing class RecurlyController 
{
	public String response{get;set;}
	
	public String planCode{get;set;}
	public String planName{get;set;}
	public Integer setupFeeInCents{get;set;}
	public Integer setupFeeInEuro{get;set;}
	public Integer unitFeeInCents{get;set;}
	public Integer unitFeeInEuro{get;set;}   
	public Integer planLength{get;set;}
	public String planIntervalUnit{get;set;}
	public Boolean taxExempt{get;set;}
	public List<selectOption> planIntervalUnitList{get;set;}
	
	public String tokenId{get;set;} 
	
	private AccountWraper accountInfo{get;set;} 
	private AddressWraper addressInfo{get;set;} 
	private BillingInfoWraper billingInfo{get;set;} 
	
	public RecurlyController()
	{
		planIntervalUnitList = new List<selectOption>();
		planIntervalUnitList.add(new selectOption('', '--None--'));
		planIntervalUnitList.add(new selectOption('months', 'Monthly' ));
		planIntervalUnitList.add(new selectOption('3months', '3 Months'));
		planIntervalUnitList.add(new selectOption('6months', '6 Months'));
		planIntervalUnitList.add(new selectOption('12months', 'Yearly'));
		
	}
	public void check()
	{
		String p =ApexPages.currentPage().getHeaders().get('True-Client-IP');
		System.debug('--first--'+p);
		String s=ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
		System.debug('--second--'+s);
	}
	public void createPlan()
	{
		if(planCode != null && planName != null && planLength!= null && planIntervalUnit != null)
		{
			HttpRequest req;
			HttpResponse res;
			Http h;
			Blob bl =  Blob.valueOf('ccdb7596923e4adbbc15cd5fd263a421');
			String cid = EncodingUtil.base64Encode(bl);
			req= new HttpRequest();
			h = new Http();
			
			
			String xmlString = 	'<?xml version="1.0" encoding="UTF-8"?>'+
								'<plan>'+
								  '<plan_code>'+planCode+'</plan_code>'+
								  '<name>'+ planName +'</name>'+
								  '<setup_fee_in_cents>'+
								  	'<USD>'+ setupFeeInCents +'</USD>'+
								    '<EUR>'+ setupFeeInEuro +'</EUR>'+
								  '</setup_fee_in_cents>'+
								  '<unit_amount_in_cents>'+
								    '<USD>'+ unitFeeInCents +'</USD>'+
								    '<EUR>'+ unitFeeInEuro +'</EUR>'+
								  '</unit_amount_in_cents>'+
								  '<plan_interval_length>'+ planLength +'</plan_interval_length>'+
								  '<plan_interval_unit>'+ planIntervalUnit +'</plan_interval_unit>'+
								  '<tax_exempt>'+ taxExempt +'</tax_exempt>'+
								'</plan>';
			
			req.setHeader('Authorization','Basic '+ cid);
			req.setHeader('Content-Type','application/xml; charset=utf-8');
			req.setHeader('Accept','application/xml');
			req.setEndpoint('https://saini.recurly.com/v2/plans');
			req.setBody(xmlString);
			req.setMethod('POST');
			res = h.send(req);
			if(res.getStatusCode() == 201)
			{
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Plan Created Succesfully'));
			}
			else
			{
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error Plan Not Created'));
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,res.getStatusCode()+':'+res.getStatus()));
				System.debug('---------Error Body-------:'+res.getBody());
			}
		}
		else
		{
			Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'All fields Are Mandatory'));
		}
	}
	public void createSubscription()
	{
		system.debug('-----tokenId------:'+tokenId);
		
			HttpRequest req;
			HttpResponse res;
			Http h;
			Blob bl =  Blob.valueOf('ccdb7596923e4adbbc15cd5fd263a421');
			String cid = EncodingUtil.base64Encode(bl);
			req= new HttpRequest();
			h = new Http();
			
			
			String xmlString = 	'<?xml version="1.0" encoding="UTF-8"?>'+
								'<subscription>'+
								  '<plan_code>bazooka_monthly</plan_code>'+
								  '<currency>USD</currency>'+
								  '<account>'+
								    '<account_code>john_rambo</account_code>'+
								    '<email>john@firstblood.com</email>'+
								    '<first_name>John</first_name>'+
								    '<last_name>Rambo</last_name>'+
								    '<billing_info>'+
								     '<token_id>'+ tokenId +'</token_id>'+
								    '</billing_info>'+
								  '</account>'+
								  '<plan_code>yahoo</plan_code>'+
								  '<unit_amount_in_cents>1000</unit_amount_in_cents>'+
								  
								  
								'</subscription>';
								
			String xmlpart2 = '<subscription>'+
								  '<plan_code>gold</plan_code>'+
								  '<currency>USD</currency>'+
								  '<account>'+
								    '<account_code>john_rambo</account_code>'+
								    '<email>john@firstblood.com</email>'+
								    '<first_name>Verena</first_name>'+
								    '<last_name>Example</last_name>'+
								    '<billing_info>'+
								      '<number>4111-1111-1111-1111</number>'+
								      '<month>1</month>'+
								      '<year>2018</year>'+
								    '</billing_info>'+
								  '</account>'+
								'</subscription>';
								
			
			req.setHeader('Authorization','Basic '+ cid);
			req.setHeader('Content-Type','application/xml; charset=utf-8');
			req.setHeader('Accept','application/xml');
			req.setEndpoint('https://saini.recurly.com/v2/subscriptions');
			req.setBody(xmlpart2);
			req.setMethod('POST');
			res = h.send(req);
			if(res.getStatusCode() == 201)
			{
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Subscribed Succesfully'));
			}
			else
			{
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Subscription Failed'));
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,res.getStatusCode()+':'+res.getStatus()));
				System.debug('---------Error Body-------:'+res.getBody());
			}
	}
	public String autoAccountId(String userName)
	{
		if(userName != null)
		{
			String Id;
			if(userName.length() >5)
			{
				Id=userName.substring(0, 5);
			}
			else
			{
				Id=userName;
			}
			Id = Id + System.currentTimeMillis();
			System.debug('---------Id----'+Id);
			return Id;
		}
		
		return null;
	}
	public void creatAccount()
	{
		accountInfo = new AccountWraper();
		addressInfo = new AddressWraper();
		billingInfo = new BillingInfoWraper();
		
		billingInfo.tokenId = tokenId;
		accountInfo.email =  Apexpages.currentPage().getParameters().get('number');
		accountInfo.first_name = Apexpages.currentPage().getParameters().get('first_name');
		accountInfo.last_name = Apexpages.currentPage().getParameters().get('last-name');
		accountInfo.vat_number = Apexpages.currentPage().getParameters().get('vat_number');
		
		addressInfo.address1 = Apexpages.currentPage().getParameters().get('address1');
		addressInfo.address2 = Apexpages.currentPage().getParameters().get('address2');
		addressInfo.city = Apexpages.currentPage().getParameters().get('city');
		addressInfo.state = Apexpages.currentPage().getParameters().get('state');
		addressInfo.zip = Apexpages.currentPage().getParameters().get('postal_code');
		addressInfo.country = Apexpages.currentPage().getParameters().get('country');
		//addressInfo.zip = ;
		
		billingInfo.year = Apexpages.currentPage().getParameters().get('year');
		billingInfo.month = Apexpages.currentPage().getParameters().get('month');
		//accountInfo.
		
		System.debug('----------- parameters:'+Apexpages.currentPage().getParameters());
			HttpRequest req;
			HttpResponse res;
			Http h;
			Blob bl =  Blob.valueOf('ccdb7596923e4adbbc15cd5fd263a421');
			String cid = EncodingUtil.base64Encode(bl);
			req= new HttpRequest();
			h = new Http();
			
			String xmlString = 	'<account>'+
		
			'<username>'+''+'</username>'+
			'<account_code>'+''+'</account_code>'+
			'<email>'+''+'</email>'+
			'<first_name>'+''+'</first_name>'+
			'<last_name>'+''+'</last_name>'+
			'<company_name>'+''+'</company_name>'+
			'<vat_number>'+''+'</vat_number>'+
			'<tax_exempt>'+''+'</tax_exempt>'+
			'<accept_language>'+''+'</accept_language>'+
			'<address>'+
				'<address1>'+''+'</address1>'+
				'<address2>'+''+'</address2>'+
				'<city>'+''+'</city>'+
				'<state>'+''+'</state>'+
				'<zip>'+''+'</zip>'+
				'<country>'+''+'</country>'+
				'<phone>'+''+'</phone>'+
			'</address>'+
			'<billing_info>'+
				'<token_id>'+''+'</token_id>'+
				
			'</billing_info>'+	 
		'</account>';
		
		
		//full
		/*String xmlString = 	'<account>'+
		
			'<username>'+''+'</username>'+
			'<account_code>'+''+'</account_code>'+
			'<email>'+''+'</email>'+
			'<first_name>'+''+'</first_name>'+
			'<last_name>'+''+'</last_name>'+
			'<company_name>'+''+'</company_name>'+
			'<vat_number>'+''+'</vat_number>'+
			'<tax_exempt>'+''+'</tax_exempt>'+
			'<accept_language>'+''+'</accept_language>'+
			'<address>'+
				'<address1>'+''+'</address1>'+
				'<address2>'+''+'</address2>'+
				'<city>'+''+'</city>'+
				'<state>'+''+'</state>'+
				'<zip>'+''+'</zip>'+
				'<country>'+''+'</country>'+
				'<phone>'+''+'</phone>'+
			'</address>'+
			'<billing_info>'+
				'<token_id>'+''+'</token_id>'+
				'<first_name>'+''+'</first_name>'+
				'<last_name>'+''+'</last_name>'+
				'<address1>'+''+'</address1>'+
				'<address2>'+''+'</address2>'+
				'<city>'+''+'</city>'+
				'<state>'+''+'</state>'+
				'<country>'+''+'</country>'+
				'<zip>'+''+'</zip>'+
				'<phone>'+''+'</phone>'+
				'<vat_number>'+''+'</vat_number>'+
				'<ip_address>'+''+'</ip_address>'+
				'<ip_address_country>'+''+'</ip_address_country>'+
				'<first_six>'+''+'</first_six>'+
				'<last_four>'+''+'</last_four>'+
				'<card_type>'+''+'</card_type>'+
				'<month>'+''+'</month>'+
				'<year>'+''+'</year>'+
				'<paypal_billing_agreement_id>'+''+'</paypal_billing_agreement_id>'+
			'</billing_info>'+	 
		'</account>';*/
		
			req.setHeader('Authorization','Basic '+ cid);
			req.setHeader('Content-Type','application/xml; charset=utf-8');
			req.setHeader('Accept','application/xml');
			req.setEndpoint('https://saini.recurly.com/v2/accounts');
			req.setBody(xmlString);
			req.setMethod('POST');
			res = h.send(req);
			if(res.getStatusCode() == 201)
			{
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Account Created Succesfully'));
			}
			else
			{
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error Occure'));
				Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,res.getStatusCode()+':'+res.getStatus()));
				System.debug('---------Error Body-------:'+res.getBody());
			}
			system.debug('-----------xmlString:'+xmlString);
	}
	public class SubscriptionWraper
	{
		//Plan code for the subscription
		String plan_code;
		//Nested account attributes
		String account	;
		//Nested add-ons
		String subscription_add_ons;
		//Optional coupon code to apply to the new subscription
		String coupon_code;
		//Override the unit amount of the subscription plan by setting this value in cents
		String unit_amount_in_cents;
		//Currency for the subscription
		String currencyType;
		//Optionally override the default quantity of 1
		String quantity;
		//If set, overrides the default trial behavior for the subscription. This must be a date and time
		String trial_ends_at;
		//If set, the subscription will begin in the future on this date
		String starts_at;
		//Renews the subscription for a specified number of cycles, then automatically cancels.
		String total_billing_cycles;
		//Indicates a date at which the first renewal should occur
		String first_renewal_date;
		
		public SubscriptionWraper(String plan_code, String currencyType, String account, String subscription_add_ons, String coupon_code, String unit_amount_in_cents, String quantity, String trial_ends_at, String starts_at, String total_billing_cycles, String first_renewal_date)
		{
			this.plan_code = plan_code;
			this.account = account;
			this.subscription_add_ons = subscription_add_ons;
			this.coupon_code = coupon_code;
			this.unit_amount_in_cents = unit_amount_in_cents;
			this.currencyType = currencyType;
			this.quantity = quantity;
			this.trial_ends_at = trial_ends_at;
			this.starts_at = starts_at;
			this.total_billing_cycles = total_billing_cycles;
			this.first_renewal_date = first_renewal_date;
		}
	}
	public class AccountWraper
	{	
		//Username, ignore if you do not use usernames
		String username;
		//A unique identifier used by your application to identify the account
		String account_code;
		//Email address
		String email;
		//First name. Max of 50 characters
		String first_name;
		//Last name. Max of 50 characters
		String last_name;
		//Company name. Max of 50 characters
		String company_name;
		//VAT number to avoid having the VAT applied (if applicable)
		String vat_number;
		//true exempts tax on the account, false applies tax on the account. If not defined, then defaults to the Plan and Site settings
		String tax_exempt;

		//An ISO 639-1 language code from the user's browser, indicating their preferred language and locale
		String accept_language;
		
		// Nested address information
		AddressWraper address;
		
		// Nested billing information
		BillingInfoWraper billing_info;
		public AccountWraper()
		{}
		public AccountWraper(String username, String account_code, String email, String first_name, String last_name, String company_name, String vat_number, String tax_exempt, AddressWraper address, String accept_language, BillingInfoWraper billing_info)
		{
			this.username = username;
			this.account_code = account_code;
			this.email = email;
			this.first_name = first_name;
			this.last_name = last_name;
			this.company_name = company_name;
			this.vat_number = vat_number;
			this.tax_exempt = tax_exempt;
			this.address = address;
			this.accept_language = accept_language;
			this.billing_info = billing_info;
		}
	}
	public class BillingInfoWraper
	{
		String first_name;
		String last_name;
		String address1;
		String address2;
		String city;
		String state;
		String country;
		String zip;
		String phone;
		//	Customer's VAT Number
		String vat_number;
		// Customer's IP address when updating their billing information
		String ip_address;	
		// Country of IP address, if known by Recurly
		String ip_address_country;	
		//Credit Card Attributes
		//Credit card number, first six digits
		String first_six;	
		//Credit card number, last four digits
		String last_four;	
		//	Visa, MasterCard, American Express, Discover, JCB, etc
		String card_type;
		//	Expiration month
		String month;
		//	Expiration year
		String year;
		//PayPal Attribute	Description
		//PayPal Billing Agreement ID
		String paypal_billing_agreement_id;
		String tokenId;
		
		public BillingInfoWraper()
		{}
		
		public BillingInfoWraper(String first_name,String last_name,String address1,String address2,String city,String state,String country,String zip,String phone,String vat_number,String ip_address,String ip_address_country,String first_six,String last_four,String card_type,String month,String year,String paypal_billing_agreement_id, String tokenId)
		{
			this.first_name = first_name;
			this.last_name = last_name;
			this.address1 = address1;
			this.address2 = address2;
			this.city = city;
			this.state = state;
			this.country = country;
			this.zip = zip;
			this.phone = phone;
			this.vat_number = vat_number;
			this.ip_address = ip_address;
			this.ip_address_country = ip_address_country;
			this.first_six = first_six;
			this.last_four = last_four;
			this.card_type = card_type;
			this.month = month;
			this.year = year;
			this.paypal_billing_agreement_id = paypal_billing_agreement_id;
			this.tokenId = tokenId;
		}
	}
	public class AddressWraper
	{

	    String address1;
	    String address2;
	    String city;
	    String state;
	    String zip;
	    String country;
	    String phone;
	    public AddressWraper()
	    {}
	    public AddressWraper(String address1,String address2,String city,String state,String zip,String country,String phone)
	    {
	    	this.address1 = address1;
	    	this.address2 = address2;
	    	this.city = city;
	    	this.state = state;
	    	this.zip = zip;
	    	this.country = country;
	    	this.phone = phone;
	    }
	}
	public class PlanWrapper
	{
		String plan_code;
		String name;
		String description;
		String accounting_code;
		String plan_interval_unit;
		String plan_interval_length;
		String trial_interval_unit;
		String trial_interval_length;
		String setup_fee_in_cents;
		String unit_amount_in_cents;
		String total_billing_cycles;
		String unit_name;
		String display_quantity;
		String success_url;
		String cancel_url;
		String tax_exempt;
		
		public PlanWrapper()
		{}
		
		public PlanWrapper(String plan_code, String name, String description, String accounting_code,String plan_interval_unit, String plan_interval_length, String trial_interval_unit, String trial_interval_length, String setup_fee_in_cents, String unit_amount_in_cents, String total_billing_cycles, String unit_name, String display_quantity, String success_url, String cancel_url, String tax_exempt)
		{
			this.plan_code = plan_code;
			this.name = name;
			this.description = description;
			this.accounting_code = accounting_code ;
			this.plan_interval_unit = plan_interval_unit ;
			this.plan_interval_length = plan_interval_length ;
			this.trial_interval_unit = trial_interval_unit;
		    this.trial_interval_length = trial_interval_length;
			this.setup_fee_in_cents = setup_fee_in_cents ;
			this.unit_amount_in_cents = unit_amount_in_cents;
			this.total_billing_cycles = total_billing_cycles ;
			this.unit_name = unit_name ;
			this.display_quantity = display_quantity ;
			this.success_url = success_url ;
			this.cancel_url = cancel_url ;
			this.tax_exempt = tax_exempt ;
		}
	}
}