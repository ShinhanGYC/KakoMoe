import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class logic {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        
        ArrayList<String> sio = new ArrayList<>();
        ArrayList<String> shoyu = new ArrayList<>();
        ArrayList<String> mayo = new ArrayList<>();
        ArrayList<String> miso = new ArrayList<>();
        
        for (int i = 1; i <= 20; i++) {
            sio.add("Sio_" + i);
            shoyu.add("Shoyu_" + i);
            mayo.add("Mayo_" + i);
            miso.add("Miso_" + i);
        }
        

        System.out.println("라운드를 설정하세요. (32강 / 16강) : ");
        int round = scanner.nextInt();
        while (round != 16 && round != 32) {
            System.out.println("잘못된 입력입니다. 32 또는 16을 선택하세요.");
            System.out.print("다시 입력해주세요 : ");
            round = scanner.nextInt();
        }

        System.out.println(round + "강을 선택하셨군요. 이상형 월드컵을 시작하겠습니다.");

        int players = round / 4;

        ArrayList<String> faces = new ArrayList<>();
        faces.addAll(sio.subList(0, players));
        faces.addAll(shoyu.subList(0, players));
        faces.addAll(mayo.subList(0, players));
        faces.addAll(miso.subList(0, players));

        Collections.shuffle(faces);

        ArrayList<String> participants = new ArrayList<>(faces);
        
        
        while (participants.size() > 1) {
            System.out.println("\n" + participants.size() + "강을 시작합니다.");
            ArrayList<String> nextRound = new ArrayList<>();

            for (int i = 0; i < participants.size(); i += 2) {
                int currentMatch = (i / 2) + 1;
                int totalMatches = participants.size() / 2;

                System.out.println("(" + currentMatch + "/" + totalMatches + ") 라운드를 진행합니다.");
                String participant1 = participants.get(i);
                String participant2 = participants.get(i + 1);

                System.out.println("1. " + participant1);
                System.out.println("2. " + participant2);
                System.out.print("승자: ");

                int choice = scanner.nextInt();
                while (choice != 1 && choice != 2) {
                    System.out.println("잘못된 입력입니다. 1 또는 2를 선택하세요: ");
                    choice = scanner.nextInt();
                }

                if (choice == 1) {
                    nextRound.add(participant1);
                } else {
                    nextRound.add(participant2);
                }
                System.out.println((choice == 1 ? participant1 : participant2) + "를 선택하셨군요.");               
                if (participants.size() > 2) { 
                    System.out.println("다음 라운드를 진행하겠습니다.");
                }

            }

            participants = nextRound;
        }

        System.out.println("축하합니다. 당신의 최애는 " + participants.get(0) + " 입니다.");
        scanner.close();
    }
}
