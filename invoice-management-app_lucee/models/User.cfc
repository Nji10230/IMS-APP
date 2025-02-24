component persistent="true" table="user"  entityname="User" {
    
    property name="id" column="id" fieldtype="id" generator="native" setter="false";
    property name="name" column="name"  ormtype="string" setter="true";
    property name="email" column="email" ormtype="string" setter="true";
    property name="password" column="password" ormtype="string" setter="false";
    property name="role" column="role" ormtype="string" setter="false";
   


    this.constraints = {
        // age = { required=true, min="18", type="numeric" },
        // email = { required=true, type="string", regex="^[\w\.-]+@[\w\.-]+\.\w{2,4}$" }
    };

    // Constraint Profiles
    this.constraintProfiles = {
        "update": {}
    };

    // Population Control
    this.population = {
        include: [],
        exclude: [ "id" ]
    };

    // Mementifier Configuration
    this.memento = {
        defaultIncludes: [ "*" ],
        defaultExcludes: [],
        neverInclude: [],
        defaults: {},
        mappers: {}
    };

    /**
     * Constructor
     */
    function init(){
        return this;
    }

    /**
     * Check if the entity is loaded
     */
    function isLoaded(){
        return !isNull( id ) && id > 0;
    }

    //generate getters and setters
    
    function getId(){
        return variables.id;
    }
    function getName(){
        return variables.name;
    }
    function getEmail(){
        return variables.email;
    }
    function getPassword(){
        return variables.password;
    }
    function getRole(){
        return variables.role;
    }   
    function setName( required string name){
        variables.name = name;
    }
    function setEmail( required string email){
        variables.email = email;
    }
    function setPassword( required string password){
        variables.password = password;
    }
    function setRole( required string role){
        variables.role = role;
    }

    
}
