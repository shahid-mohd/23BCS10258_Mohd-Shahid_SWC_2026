// Question 3: PiggyBank with Synchronized Access (5 threads)

class PiggyBank {
    private int balance = 0;

    public synchronized void deposit(int amount) {
        String threadName = Thread.currentThread().getName();

        System.out.println(threadName + " is depositing ₹" + amount);

        balance += amount;

        System.out.println(threadName +
                " completed deposit. Current Balance = ₹" + balance);
    }

    public int getBalance() {
        return balance;
    }
}

class Depositor extends Thread {
    private PiggyBank piggyBank;
    private int amount;

    public Depositor(PiggyBank piggyBank, int amount) {
        this.piggyBank = piggyBank;
        this.amount = amount;
    }

    @Override
    public void run() {
        piggyBank.deposit(amount);
    }
}

public class PiggyBankDemo {
    public static void main(String[] args) throws InterruptedException {

        PiggyBank bank = new PiggyBank();

        Depositor t1 = new Depositor(bank, 100);
        Depositor t2 = new Depositor(bank, 200);
        Depositor t3 = new Depositor(bank, 300);
        Depositor t4 = new Depositor(bank, 400);
        Depositor t5 = new Depositor(bank, 500);

        t1.setName("Thread-1");
        t2.setName("Thread-2");
        t3.setName("Thread-3");
        t4.setName("Thread-4");
        t5.setName("Thread-5");

        t1.start();
        t2.start();
        t3.start();
        t4.start();
        t5.start();
        
        t1.join();
        t2.join();
        t3.join();
        t4.join();
        t5.join();

        System.out.println("\nFinal Balance = ₹" + bank.getBalance());
    }
}
