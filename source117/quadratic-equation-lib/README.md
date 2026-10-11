# Source 117 — Quadratic Equation Solver Library

Thư viện Java Maven dùng để giải phương trình:

`ax² + bx + c = 0`

## API

Lớp chính: `com.codegym.QuadraticEquationSolver`

Gọi:

~~~java
QuadraticEquationSolver.Solution result =
        QuadraticEquationSolver.solve(1, -3, 2);

System.out.println(result.getType());  // TWO_REAL_ROOTS
System.out.println(result.getRoots()); // [1.0, 2.0]
~~~

Các kiểu kết quả:
- `TWO_REAL_ROOTS`: hai nghiệm thực.
- `ONE_REAL_ROOT`: nghiệm kép.
- `NO_REAL_ROOTS`: không có nghiệm thực.
- `LINEAR_EQUATION`: `a = 0`, chuyển thành phương trình bậc nhất.
- `NO_SOLUTION`: vô nghiệm.
- `INFINITE_SOLUTIONS`: vô số nghiệm.

Thư viện trả về nghiệm thực theo thứ tự tăng dần. Hệ số không hữu hạn (`NaN`, vô cực) bị từ chối bằng `IllegalArgumentException`.

## Build và kiểm thử

Yêu cầu JDK 17+ và Maven. Từ thư mục `source117/quadratic-equation-lib`, chạy:

~~~bash
mvn clean test
mvn clean package
~~~

JAR được tạo tại:

`target/quadratic-equation-lib-1.0-SNAPSHOT.jar`

## Dùng JAR trong dự án Maven khác

Sau khi build JAR, có thể cài thư viện vào Maven local repository:

~~~bash
mvn install
~~~

Rồi khai báo dependency trong ứng dụng:

~~~xml
<dependency>
    <groupId>com.codegym</groupId>
    <artifactId>quadratic-equation-lib</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
~~~

## Cấu trúc

- `src/main/java/com/codegym/QuadraticEquationSolver.java`: API giải phương trình.
- `src/test/java/com/codegym/QuadraticEquationSolverTest.java`: kiểm thử các trường hợp nghiệm.
- `pom.xml`: cấu hình đóng gói JAR và JUnit 5.