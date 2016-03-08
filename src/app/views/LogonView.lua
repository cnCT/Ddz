local LogonView = class("LogonView", cc.load("mvc").ViewBase)
LogonView.RESOURCE_FILENAME = "Login.csb"
LogonView.RESOURCE_BINDING = {
	Button_1_2_6_10 = {
		varname = "Button_Logon",
		events = {
		
		},
	},

}

function LogonView:onCreate()
	print(self.Button_Logon)
end

return LogonView