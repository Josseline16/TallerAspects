import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Calendar;


public aspect Log {

    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut successTransaction() : call(* moneyMakeTransaction(..) );
    after() : successTransaction() {
    	System.out.println(cal.getTime());
    	try (PrintWriter pw = new PrintWriter(new FileOutputStream(file,true))) {
    		pw.println (cal.getTime() + " Deposito");
    	} catch (Exception e){
    		System.out.println(e.getMessage());
    	}
    }
    pointcut successRetiro() : call(* moneyWithdrawal(..) );
    after() : successRetiro() {
    	System.out.println(cal.getTime());
    	try (PrintWriter pw = new PrintWriter(new FileOutputStream(file,true))) {
    		pw.println (cal.getTime() + " Retiro");
    	} catch (Exception e){
    		System.out.println(e.getMessage());
    	}
    }
    pointcut success() : call(* create*(..) );
    after() : success() {
    	System.out.println("**** User created ****");
    }
}


