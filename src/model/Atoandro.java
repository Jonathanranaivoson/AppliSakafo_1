package model;

public class Atoandro extends Recette {
    private int groupe;

    public Atoandro() {}

    public Atoandro(int id, String nom, int groupe) {
        super(id, nom);
        this.groupe = groupe;
    }

    public int getGroupe() { return groupe; }

    public void setGroupe(int groupe) { this.groupe = groupe; }
}
