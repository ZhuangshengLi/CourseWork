import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class DneProfileDiagnosis {

    private String dna;
    private Map<String, String> map;

    //build a database from database.csv
    public DneProfileDiagnosis (String database){
        File file = new File(database);
        map = new HashMap<String, String>();

        try{
            Scanner sc = new Scanner(file);
            String firstline = sc.nextLine();
            String[] STR = firstline.split(",");

            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] count = line.split(",");
                String name = count[0];
                for(int i = 1; i < count.length; i++){
                    this.map.put(name+STR[i], count[i]);
                }
            }
            sc.close();
        }  catch (IOException e) {
            e.printStackTrace();
        }
    }

    //store a dna sequence with no whitespace from dna.txt
    public void readDna(String dna){
        File file = new File(dna);
        this.dna = "";
        try{
            Scanner sc = new Scanner(file);
            var StringBuilder = new StringBuilder(this.dna);
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                StringBuilder.append(line);
            }
            this.dna = StringBuilder.toString();

            sc.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        this.dna = this.dna.replaceAll(" ","");
        this.dna = this.dna.replaceAll("\t","");
        this.dna = this.dna.replaceAll("\n","");
    }

    //based on the STR counts, retuen either a name in
    //database, or"No Match"
    //throws IllegalArgumentException if dna has not been set
    public String checkProfile(){

        if (this.dna == null || this.dna.length() < 4){
            throw new IllegalArgumentException("dna has not been set");
        }

        var pair = new HashMap<String, ArrayList<String>>();

        for(String key : this.map.keySet()){
            String name = key.substring(0, key.length()-4);
            String Str = key.substring(key.length()-5);
            String count = this.map.get(key);

            var list = pair.getOrDefault(name, new ArrayList<>());
            list.add(Str+count);
            pair.put(name, list);
        }

        for(String name : pair.keySet()){
            int flag  = 0;
            var list = pair.get(name);

            for (String s : list) {
                String str = s.substring(0, 4);
                int num = Integer.parseInt(s.substring(3));
                int count = 0, conti = 0;

                for(int i = 0; i < this.dna.length() - 4; i++){
                    String next = dna.substring(i, i+4);
                    if(str.equals(next)){
                        conti++;
                        i += 3;
                    }else{
                        if(conti > 1){
                            count += conti;
                            conti = 0;
                        }
                    }
                }
                if(conti > 1)  count += conti;

                if(num != count) break;
                else flag++;
            }

            if(flag >= list.size()) return name;
        }


        return "No Match";
    }


    // based on the CAG repeats, return either "Faulty Test",
    // "Normal", "High Risk", or "Huntington's"
    // throws IllegalArgumentException if dna has not been set
    public String diagnoseHd(){
        if (this.dna == null || this.dna.length() < 3){
            throw new IllegalArgumentException("dna has not been set");
        }

        int count = 0, conti = 0;

        for(int i = 0; i < this.dna.length() - 3; i++){
            String next = dna.substring(i, i+3);
            if("CAG".equals(next)){
                conti++;
                i += 2;
            }else{
                if(conti > 1){
                    count += conti;
                    conti = 0;
                }
            }
        }
        if(conti > 1)  count += conti;


        String res = "";
        if(0 <= count && count <= 9){
            res = "Faulty Test";
        }
        else if(10 <= count && count <= 35){
            res = "Normal";
        }
        else if(36 <= count && count <= 39){
            res = "High Risk";
        }
        else if(40 <= count && count <= 180){
            res = "Huntington's";
        }
        else{
            res = "Faulty Test";
        }
        return res;
    }

}
