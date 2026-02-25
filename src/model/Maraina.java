package model;

public class Maraina extends Recette {
    private int groupe;

    public Maraina() {}

    public Maraina(int id, String nom, int groupe) {
        super(id, nom);
        this.groupe = groupe;
    }

    public int getGroupe() { return groupe; }

    public void setGroupe(int groupe) { this.groupe = groupe; }
}
