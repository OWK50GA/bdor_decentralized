import ListCandidates from "@/components/pages/candidates/ListCandidates";
import NomineesList from "@/components/pages/candidates/NomineesList";

const Candidates = () => {
    return ( 
        <div className="w-10/12 mx-auto mt-10">
            <div className="flex justify-between px-4">
                <ListCandidates />
                <p>Charts</p>
            </div>

            <p className="mt-5">
                A player deserves it in your opinion that isn't here?
                Nominate them
            </p>

            <div>
                <NomineesList />
            </div>
        </div>
    );
}
 
export default Candidates;