package model;

public class RecetteAjoutee {
    private int id;
    private String nom;
    private String typeRepas; 
    private String dateAjout;

    public RecetteAjoutee() {}

    public RecetteAjoutee(int id, String nom, String typeRepas, String dateAjout) {
        this.id = id;
        this.nom = nom;
        this.typeRepas = typeRepas;
        this.dateAjout = dateAjout;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getTypeRepas() { return typeRepas; }
    public void setTypeRepas(String typeRepas) { this.typeRepas = typeRepas; }
    public String getDateAjout() { return dateAjout; }
    public void setDateAjout(String dateAjout) { this.dateAjout = dateAjout; }

    public String getTypeRepasLabel() {
        switch (typeRepas) {
            case "petit-dejeuner": return "Petit-Dejeuner";
            case "dejeuner": return "Dejeuner";
            case "diner": return "Diner";
            default: return typeRepas;
        }
    }
}
