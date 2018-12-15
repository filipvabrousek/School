 firebase.database().ref().delete = null;
     firebase.database().ref().remove = null;

     var entities = ["Users", "No", "Yes", "Reports", "chatids", "fcmAuth", "myfiles"]
     entities.forEach((val, i) => {
     	 console.log(firebase.database().ref("" + entities[i]+ ""));
     	firebase.database().ref("" + entities[i] + "").remove = null; 
        firebase.database().ref("" + entities[i] + "").delete = null; 
     });

     const disableDevtools = callback => {
     	const original = Object.getPrototypeOf;
     	Object.getPrototypeOf = (...args) => {
     		if (Error().stack.includes("getCompletions")) callback();
     		return original(...args);
     	};
     };
    
     disableDevtools(() => {
     	// console.error("Error occured. Please close and reopen the window.");
     	console.clear();
     	console.log("%cConsole blocked. Please reopen this browser tab.", "background: red; color: yellow; font-size: x-large");
     	while (1);
     });
    
