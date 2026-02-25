package model;

public class Hariva extends Recette {
    private int groupe;

    public Hariva() {}

    public Hariva(int id, String nom, int groupe) {
        super(id, nom);
        this.groupe = groupe;
    }

    public int getGroupe() { return groupe; }

    public void setGroupe(int groupe) { this.groupe = groupe; }
}
