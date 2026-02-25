package model;

public class MenuJournalier {
    private int id;
    private int groupe;
    private int jour;
    private MenuMaraina menuMaraina;
    private Atoandro atoandro;
    private Hariva hariva;
    private boolean fait;
    private String dateFait;

    public MenuJournalier() {}

    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public int getGroupe() { return groupe; }

    public void setGroupe(int groupe) { this.groupe = groupe; }

    public int getJour() { return jour; }

    public void setJour(int jour) { this.jour = jour; }

    public MenuMaraina getMenuMaraina() { return menuMaraina; }

    public void setMenuMaraina(MenuMaraina menuMaraina) { this.menuMaraina = menuMaraina; }

    public Atoandro getAtoandro() { return atoandro; }

    public void setAtoandro(Atoandro atoandro) { this.atoandro = atoandro; }

    public Hariva getHariva() { return hariva; }

    public void setHariva(Hariva hariva) { this.hariva = hariva; }

    public boolean isFait() { return fait; }

    public void setFait(boolean fait) { this.fait = fait; }

    public String getDateFait() { return dateFait; }

    public void setDateFait(String dateFait) { this.dateFait = dateFait; }

    public String getNomJour() {
        String[] jours = {"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"};
        if (jour >= 1 && jour <= 6) return jours[jour - 1];
        return "Jour " + jour;
    }
}
