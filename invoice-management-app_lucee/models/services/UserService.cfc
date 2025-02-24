component singleton{


     UserService function init(){
        return this;
     }

     function getAllUsers() {
        return entityLoad("User");
    }

    function getUser(userId) {
        return entityLoadByPK("User", userId);
    }

    function createUser(required struct userData) {
        try {
            var user = entityNew("User");
            user.setName(userData.name);
            user.setEmail(userData.email);
            user.setPassword(hash(userData.password, "SHA-256"));
            user.setRole(userData.role);
            
            entitySave(user);
            ormFlush();
            
            return {
                id: user.getId(),
                name: user.getName(),
                email: user.getEmail(),
                role: user.getRole()
            };
        } catch(any e) {
            throw(
                type="UserService.CreateUserError",
                message="Error creating user: " & e.message,
                detail=e.detail
            );
        }
    }

    function updateUser(userData) {
        var user = getUser(userData.id);
        if (!user) return null;
        if (userData.name != "") user.setName(userData.name);
        if (userData.email != "") user.setEmail(userData.email);
        if (userData.password != "") user.setPassword(hash(userData.password, "SHA-256"));
        user.setRole(userData.role);
        entitySave(user);
        return user;
    }

    function deleteUser(userId) {
        var user = getUser(userId);
        if (user) {
            entityDelete(user);
            return true;
        }
        return false;
    }
    
}