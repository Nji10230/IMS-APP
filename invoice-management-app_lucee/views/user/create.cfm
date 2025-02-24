<html>
<head>
    <title>Create New User</title>
    <style>
        .form-container {
            max-width: 500px;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .btn-submit:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>
<cfoutput>
    <div class="form-container">
        <h2>Create New User</h2>
        <p><strong>Date:</strong> #dateFormat(now(), "mmmm dd, yyyy")#</p>

        <form id="userForm" onsubmit="return handleSubmit(event)">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                <div id="nameError" class="error">Please enter a valid name</div>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required minlength="6">
            </div>
            <div class="form-group">
                <label for="role">Role:</label>
                <select id="role" name="role">
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn-submit">Create User</button>
        </form>
    </div>
    <script>
        function handleSubmit(event) {
            event.preventDefault();
            document.querySelectorAll('.error').forEach(error => error.style.display = 'none');
            const userName = document.getElementById('name').value.trim();
            const userEmail = document.getElementById('email').value.trim();
            const userPassword = document.getElementById('password').value;
            const userRole = document.getElementById('role').value;
            let isValid = true;
            if (userName.length < 2) {
                document.getElementById('nameError').style.display = 'block';
                isValid = false;
            }
            if (isValid) {
                const userData = {
                    name: userName,
                    email: userEmail,
                    password: userPassword,
                    role: userRole
                };
                fetch('/user/create', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    },
    body: JSON.stringify(userData)
})
.then(response => {
    // First check if the response is JSON
    const contentType = response.headers.get("content-type");
    if (contentType && contentType.indexOf("application/json") !== -1) {
        return response.json().then(data => {
            if (!response.ok) {
                throw new Error(data.message || 'Failed to create user');
            }
            return data;
        });
    } else {
        throw new Error('Received non-JSON response from server');
    }
})
.then(data => {
    if (data.success) {
        alert(data.message);
        document.getElementById('userForm').reset();
    } else {
        throw new Error(data.message || 'Failed to create user');
    }
})
.catch(error => {
    console.error('Error:', error);
    alert(error.message);
});
            }
            return false;
        }
    </script>
</cfoutput>
</body>
</html>

