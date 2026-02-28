package model;

public class SemaineGroupe {
    private int id;
    private int groupe;
    private String dateDebut;
    private String dateFin;

    public SemaineGroupe() {}

    public SemaineGroupe(int id, int groupe, String dateDebut, String dateFin) {
        this.id = id;
        this.groupe = groupe;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getGroupe() { return groupe; }
    public void setGroupe(int groupe) { this.groupe = groupe; }

    public String getDateDebut() { return dateDebut; }
    public void setDateDebut(String dateDebut) { this.dateDebut = dateDebut; }

    public String getDateFin() { return dateFin; }
    public void setDateFin(String dateFin) { this.dateFin = dateFin; }

    // Méthode pour formater l'affichage : "01/03 - 07/03"
    public String getPeriodeFormatee() {
        if (dateDebut == null || dateFin == null) return "";
        try {
            String[] debut = dateDebut.split("-");
            String[] fin = dateFin.split("-");
            return debut[2] + "/" + debut[1] + " - " + fin[2] + "/" + fin[1];
        } catch (Exception e) {
            return dateDebut + " - " + dateFin;
        }
    }
}
