
component  extends="coldbox.system.EventHandler" {

    //di
    property name="userService" inject="models:services.UserService";
     
    function index(event, rc, prc) {
        prc.users = userService.getAllUsers();
        event.renderData(type="json", data=prc.users);
    }

    function get(event, rc, prc) {
        if (!structKeyExists(rc, "id")) {
            event.renderData(type="json", data={ error="User ID required" }, statusCode=400);
            return;
        }
        var user = userService.getUser(rc.id);
        if (!user) {
            event.renderData(type="json", data={ error="User not found" }, statusCode=404);
        } else {
            event.renderData(type="json", data=user);
        }
    }

    function create(event, rc, prc) {
        var userData = {};
        
        // Check if it's a JSON request by examining the Content-Type header
        if (event.getHTTPHeader("Content-Type") == "application/json") {
            // Parse JSON body
            userData = deserializeJSON(event.getHTTPContent());
        } else {
            // Handle form submission
            userData = {
                name = rc.name ?: "",
                email = rc.email ?: "",
                password = rc.password ?: "",
                role = rc.role ?: "user"    
            };
        }
    
        // Validate required fields
        if (!structKeyExists(userData, "name") || !len(trim(userData.name))) {
            event.renderData(type="json", data={
                "success": false,
                "message": "Name is required"
            }, statusCode=400);
            return;
        }
    
        try {
            // Create the user
            var user = userService.createUser(userData);
            
            // Return success response
            event.renderData(type="json", data={
                "success": true,
                "message": "User created successfully",
                "user": user
            }, statusCode=201);
        } catch(any e) {
            // Return error response
            event.renderData(type="json", data={
                "success": false,
                "message": "Error creating user: " & e.message
            }, statusCode=500);
        }
    }

    function update(event, rc, prc) {
        if (!structKeyExists(rc, "id")) {
            event.renderData(type="json", data={ error="User ID required" }, statusCode=400);
            return;
        }
        var userData = {
            id      = rc.id,
            name    = rc.name ?: "",
            email   = rc.email ?: "",
            password= rc.password ?: "",
            role    = rc.role ?: "user"
        };
        var updatedUser = userService.updateUser(userData);
        event.renderData(type="json", data=updatedUser);
    }

    function delete(event, rc, prc) {
        if (!structKeyExists(rc, "id")) {
            event.renderData(type="json", data={ error="User ID required" }, statusCode=400);
            return;
        }
        var success = userService.deleteUser(rc.id);
        event.renderData(type="json", data={ success=success });
    }

    // create the form for creating a new user
    function new(event, rc, prc) {

        event.setView("user/create");

    }


}