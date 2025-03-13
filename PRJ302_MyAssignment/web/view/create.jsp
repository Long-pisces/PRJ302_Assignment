<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn xin nghỉ phép</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #ffe5d1;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 25px 30px;
            width: 360px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 22px;
            color: #333;
        }

        .user-info {
            margin-bottom: 20px;
            font-size: 14px;
            line-height: 1.6;
        }

        .user-info strong {
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .form-group input[type="date"],
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .form-group textarea {
            resize: none;
            height: 90px;
        }

        .submit-btn {
            background-color: #3366cc;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #27408b;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Đơn xin nghỉ phép</h2>

        <div class="user-info">
            <p><strong>User:</strong> ______________________</p>
            <p><strong>Role:</strong> ______________________</p>
            <p><strong>Dep:</strong> ______________________</p>
        </div>

        <form action="submitLeaveRequest" method="POST">
            <div class="form-group">
                <label for="start-date">Từ ngày:</label>
                <input type="date" id="start-date" name="start_date" required>
            </div>

            <div class="form-group">
                <label for="end-date">Tới ngày:</label>
                <input type="date" id="end-date" name="end_date" required>
            </div>

            <div class="form-group">
                <label for="reason">Lý do:</label>
                <textarea id="reason" name="reason" placeholder="Nhập lý do..." required></textarea>
            </div>

            <button type="submit" class="submit-btn">Gửi</button>
        </form>
    </div>

</body>
</html>
