import { LightningElement, api } from 'lwc';

export default class BookingManager extends LightningElement {
    @api selectedJetId;
    handleJetSelected(evt) {
        this.selectedJetId = evt.detail;
    }
}