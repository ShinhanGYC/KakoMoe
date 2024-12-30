import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Scanner;

class ParticipantManager {
    private ArrayList<String> participants;

    public ParticipantManager() {
        this.participants = new ArrayList<>();
    }

    public void addParticipants(String type, int count) {
        for (int i = 1; i <= count; i++) {
            participants.add(type + "_" + i);
        }
    }

    public ArrayList<String> getUniqueShuffledParticipants(int totalSize, int perGroupSize) {
        HashSet<String> selected = new HashSet<>();
        ArrayList<String> subset = new ArrayList<>();
        Collections.shuffle(participants);

        for (String participant : participants) {
            if (selected.size() >= totalSize) break;
            if (!selected.contains(participant) && selected.size() % perGroupSize < perGroupSize) {
                selected.add(participant);
                subset.add(participant);
            }
        }

        return subset;
    }
}

class WorldCupGame {
    private ArrayList<String> participants;
    private Scanner scanner;

    public WorldCupGame(ArrayList<String> participants) {
        this.participants = participants;
        this.scanner = new Scanner(System.in);
    }

    public void startGame() {
        while (participants.size() > 1) {
            int totalMatches = participants.size() / 2;
            System.out.println("\n" + participants.size() + "강을 시작합니다.");
            ArrayList<String> nextRound = new ArrayList<>();

            for (int i = 0; i < participants.size(); i += 2) {
                String participant1 = participants.get(i);
                String participant2 = participants.get(i + 1);

                int currentMatch = (i / 2) + 1;
                System.out.println("(" + currentMatch + "/" + totalMatches + ") 라운드를 진행합니다.");
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
            }

            participants = nextRound;
        }

        System.out.println("축하합니다. 당신의 최애는 " + participants.get(0) + " 입니다.");
    }
}

public class logic {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ParticipantManager manager = new ParticipantManager();

        manager.addParticipants("Sio", 20);
        manager.addParticipants("Shoyu", 20);
        manager.addParticipants("Mayo", 20);
        manager.addParticipants("Miso", 20);

        System.out.println("라운드를 설정하세요. (32강 / 16강) : ");
        int round = scanner.nextInt();
        while (round != 16 && round != 32) {
            System.out.println("잘못된 입력입니다. 32 또는 16을 선택하세요.");
            System.out.print("다시 입력해주세요 : ");
            round = scanner.nextInt();
        }

        System.out.println(round + "강을 선택하셨군요. 이상형 월드컵을 시작하겠습니다.");

        int playersPerCategory = round / 4;
        ArrayList<String> faces = manager.getUniqueShuffledParticipants(round, playersPerCategory);

        WorldCupGame game = new WorldCupGame(faces);
        game.startGame();

        scanner.close();
    }
}
