package model;

public class MenuDimanche {
    private int id;
    private String nomPlat;
    private String typeRepas; // petit-dejeuner, dejeuner, diner
    private String dateMenu;
    private String dateAjout;

    public MenuDimanche() {}

    public MenuDimanche(int id, String nomPlat, String typeRepas, String dateMenu, String dateAjout) {
        this.id = id;
        this.nomPlat = nomPlat;
        this.typeRepas = typeRepas;
        this.dateMenu = dateMenu;
        this.dateAjout = dateAjout;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNomPlat() { return nomPlat; }
    public void setNomPlat(String nomPlat) { this.nomPlat = nomPlat; }
    public String getTypeRepas() { return typeRepas; }
    public void setTypeRepas(String typeRepas) { this.typeRepas = typeRepas; }
    public String getDateMenu() { return dateMenu; }
    public void setDateMenu(String dateMenu) { this.dateMenu = dateMenu; }
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
