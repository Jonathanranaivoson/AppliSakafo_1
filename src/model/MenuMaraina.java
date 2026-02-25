package model;

public class MenuMaraina {
    private int id;
    private Maraina maraina;
    private Boisson boisson;

    public MenuMaraina() {}

    public MenuMaraina(int id, Maraina maraina, Boisson boisson) {
        this.id = id;
        this.maraina = maraina;
        this.boisson = boisson;
    }

    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public Maraina getMaraina() { return maraina; }

    public void setMaraina(Maraina maraina) { this.maraina = maraina; }

    public Boisson getBoisson() { return boisson; }

    public void setBoisson(Boisson boisson) { this.boisson = boisson; }

    @Override
    public String toString() {
        return maraina.getNom() + " + " + boisson.getNom();
    }
}
