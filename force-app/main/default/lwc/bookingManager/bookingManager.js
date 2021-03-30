import { LightningElement } from 'lwc';

export default class BookingManager extends LightningElement {
    selectedJetId
    handleJetSelected(evt) {
        this.selectedJetId = evt.detail;
    }
}